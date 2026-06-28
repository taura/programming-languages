#[derive(Clone, Debug, PartialEq)]
pub enum Tok {
    Num(i64),
    Id(String),
    Long,
    Return,
    If,
    Else,
    Break,
    Continue,
    LParen,
    RParen,
    LBrace,
    RBrace,
    Comma,
    Semi,
    Assign,
    Eq,
    Ne,
    Lt,
    Gt,
    Le,
    Ge,
    Plus,
    Minus,
    Star,
    Slash,
    Percent,
    Not,
    Tilde,
    Eof,
}

pub fn tok_to_string(t: &Tok) -> String {
    let s = match t {
        Tok::Num(n) => return format!("NUM({})", n),
        Tok::Id(s) => return format!("ID({})", s),
        Tok::Long => "long",
        Tok::Return => "return",
        Tok::If => "if",
        Tok::Else => "else",
        Tok::Break => "break",
        Tok::Continue => "continue",
        Tok::LParen => "(",
        Tok::RParen => ")",
        Tok::LBrace => "{",
        Tok::RBrace => "}",
        Tok::Comma => ",",
        Tok::Semi => ";",
        Tok::Assign => "=",
        Tok::Eq => "==",
        Tok::Ne => "!=",
        Tok::Lt => "<",
        Tok::Gt => ">",
        Tok::Le => "<=",
        Tok::Ge => ">=",
        Tok::Plus => "+",
        Tok::Minus => "-",
        Tok::Star => "*",
        Tok::Slash => "/",
        Tok::Percent => "%",
        Tok::Not => "!",
        Tok::Tilde => "~",
        Tok::Eof => "<eof>",
    };
    s.to_string()
}

fn keyword(w: &str) -> Option<Tok> {
    match w {
        "long" => Some(Tok::Long),
        "return" => Some(Tok::Return),
        "if" => Some(Tok::If),
        "else" => Some(Tok::Else),
        "break" => Some(Tok::Break),
        "continue" => Some(Tok::Continue),
        _ => None,
    }
}

fn is_digit(c: u8) -> bool {
    c.is_ascii_digit()
}
fn is_alpha(c: u8) -> bool {
    c.is_ascii_alphabetic() || c == b'_'
}
fn is_alnum(c: u8) -> bool {
    is_alpha(c) || is_digit(c)
}
fn is_space(c: u8) -> bool {
    c == b' ' || c == b'\t' || c == b'\n' || c == b'\r'
}

pub fn tokenize(s: &str) -> Result<Vec<Tok>, String> {
    let b = s.as_bytes();
    let n = b.len();
    let mut toks = Vec::new();
    let mut i = 0;
    let peek = |i: usize, k: usize| -> u8 {
        if i + k < n { b[i + k] } else { 0 }
    };
    while i < n {
        let c = b[i];
        if is_space(c) {
            i += 1;
        } else if c == b'/' && peek(i, 1) == b'/' {
            while i < n && b[i] != b'\n' {
                i += 1;
            }
        } else if c == b'/' && peek(i, 1) == b'*' {
            i += 2;
            while i < n && !(b[i] == b'*' && peek(i, 1) == b'/') {
                i += 1;
            }
            if i >= n {
                return Err("lex error: unterminated block comment".to_string());
            }
            i += 2;
        } else if is_digit(c) {
            let start = i;
            while i < n && is_digit(b[i]) {
                i += 1;
            }
            let v: i64 = s[start..i].parse().unwrap_or(0);
            toks.push(Tok::Num(v));
        } else if is_alpha(c) {
            let start = i;
            while i < n && is_alnum(b[i]) {
                i += 1;
            }
            let word = &s[start..i];
            match keyword(word) {
                Some(kw) => toks.push(kw),
                None => toks.push(Tok::Id(word.to_string())),
            }
        } else {
            if c == b'=' && peek(i, 1) == b'=' {
                toks.push(Tok::Eq);
                i += 2;
            } else if c == b'!' && peek(i, 1) == b'=' {
                toks.push(Tok::Ne);
                i += 2;
            } else if c == b'<' && peek(i, 1) == b'=' {
                toks.push(Tok::Le);
                i += 2;
            } else if c == b'>' && peek(i, 1) == b'=' {
                toks.push(Tok::Ge);
                i += 2;
            } else {
                let t = match c {
                    b'(' => Tok::LParen,
                    b')' => Tok::RParen,
                    b'{' => Tok::LBrace,
                    b'}' => Tok::RBrace,
                    b',' => Tok::Comma,
                    b';' => Tok::Semi,
                    b'=' => Tok::Assign,
                    b'<' => Tok::Lt,
                    b'>' => Tok::Gt,
                    b'+' => Tok::Plus,
                    b'-' => Tok::Minus,
                    b'*' => Tok::Star,
                    b'/' => Tok::Slash,
                    b'%' => Tok::Percent,
                    b'!' => Tok::Not,
                    b'~' => Tok::Tilde,
                    _ => {
                        return Err(format!(
                            "lex error: unexpected character {:?} at offset {}",
                            c as char, i
                        ));
                    }
                };
                toks.push(t);
                i += 1;
            }
        }
    }
    toks.push(Tok::Eof);
    Ok(toks)
}
