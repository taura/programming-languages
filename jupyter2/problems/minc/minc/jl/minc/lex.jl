@enum TokKind begin
    TNum
    TId
    TLong
    TReturn
    TIf
    TElse
    TBreak
    TContinue
    TLParen
    TRParen
    TLBrace
    TRBrace
    TComma
    TSemi
    TAssign
    TEq
    TNe
    TLt
    TGt
    TLe
    TGe
    TPlus
    TMinus
    TStar
    TSlash
    TPercent
    TNot
    TTilde
    TEOF
end

struct Token
    kind::TokKind
    num::Int64
    str::String
end
Token(k::TokKind) = Token(k, 0, "")

const TOK_NAMES = Dict(
    TLong => "long", TReturn => "return", TIf => "if", TElse => "else",
    TBreak => "break", TContinue => "continue",
    TLParen => "(", TRParen => ")", TLBrace => "{", TRBrace => "}",
    TComma => ",", TSemi => ";", TAssign => "=", TEq => "==", TNe => "!=",
    TLt => "<", TGt => ">", TLe => "<=", TGe => ">=", TPlus => "+", TMinus => "-",
    TStar => "*", TSlash => "/", TPercent => "%", TNot => "!", TTilde => "~",
    TEOF => "<eof>",
)

function tokstr(t::Token)
    if t.kind == TNum
        return "NUM($(t.num))"
    elseif t.kind == TId
        return "ID($(t.str))"
    end
    return TOK_NAMES[t.kind]
end

const KEYWORDS = Dict(
    "long" => TLong, "return" => TReturn, "if" => TIf, "else" => TElse,
    "break" => TBreak, "continue" => TContinue,
)

isdigit_(c::Char) = c >= '0' && c <= '9'
isalpha_(c::Char) = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_'
isalnum_(c::Char) = isalpha_(c) || isdigit_(c)
isspace_(c::Char) = c == ' ' || c == '\t' || c == '\n' || c == '\r'

# report an error at the point it occurs and return nothing
function lexfail(msg::String)
    println(stderr, "lex error: " * msg)
    return nothing
end

function tokenize(s::String)::Union{Vector{Token},Nothing}
    b = collect(s)
    n = length(b)
    toks = Token[]
    i = 1
    peek(k) = (i + k <= n) ? b[i+k] : '\0'
    while i <= n
        c = b[i]
        if isspace_(c)
            i += 1
        elseif c == '/' && peek(1) == '/'
            while i <= n && b[i] != '\n'
                i += 1
            end
        elseif c == '/' && peek(1) == '*'
            i += 2
            while i <= n && !(b[i] == '*' && peek(1) == '/')
                i += 1
            end
            if i > n
                return lexfail("unterminated block comment")
            end
            i += 2
        elseif isdigit_(c)
            start = i
            while i <= n && isdigit_(b[i])
                i += 1
            end
            v = parse(Int64, String(b[start:i-1]))
            push!(toks, Token(TNum, v, ""))
        elseif isalpha_(c)
            start = i
            while i <= n && isalnum_(b[i])
                i += 1
            end
            word = String(b[start:i-1])
            if haskey(KEYWORDS, word)
                push!(toks, Token(KEYWORDS[word]))
            else
                push!(toks, Token(TId, 0, word))
            end
        elseif c == '=' && peek(1) == '='
            push!(toks, Token(TEq))
            i += 2
        elseif c == '!' && peek(1) == '='
            push!(toks, Token(TNe))
            i += 2
        elseif c == '<' && peek(1) == '='
            push!(toks, Token(TLe))
            i += 2
        elseif c == '>' && peek(1) == '='
            push!(toks, Token(TGe))
            i += 2
        else
            k = if c == '('
                TLParen
            elseif c == ')'
                TRParen
            elseif c == '{'
                TLBrace
            elseif c == '}'
                TRBrace
            elseif c == ','
                TComma
            elseif c == ';'
                TSemi
            elseif c == '='
                TAssign
            elseif c == '<'
                TLt
            elseif c == '>'
                TGt
            elseif c == '+'
                TPlus
            elseif c == '-'
                TMinus
            elseif c == '*'
                TStar
            elseif c == '/'
                TSlash
            elseif c == '%'
                TPercent
            elseif c == '!'
                TNot
            elseif c == '~'
                TTilde
            else
                return lexfail("unexpected character '$(c)' at offset $(i)")
            end
            push!(toks, Token(k))
            i += 1
        end
    end
    push!(toks, Token(TEOF))
    return toks
end
