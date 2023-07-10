grammar InputExpression;

expression: expr (operator expr)*;

expr: function | number | lBrecket expression rBrecket;

function: unaryOperator? fun lBrecket expression rBrecket;

fun: Sin | Cos | Tan | Asin | Acos | Atan | Sqrt | Ln | Log;
operator: Plus | Minus | Mult | Div | Mod | Pow;
unaryOperator: Plus | Minus;
number: unaryOperator? Number;
lBrecket: '(';
rBrecket: ')';

Number: [0-9]+ ('.' [0-9]+)?;
Plus: '+';
Minus: '-';
Mult: '*';
Div: '/';
Mod: '%' | 'mod';
Pow: '^';
Sin: [Ss] [Ii] [Nn];
Cos: [Cc] [Oo] [Ss];
Tan: [Tt] [Aa] [Nn];
Asin: [Aa] [Ss] [Ii] [Nn];
Acos: [Aa] [Cc] [Oo] [Ss];
Atan: [Aa] [Tt] [Aa] [Nn];
Sqrt: [Ss] [Qq] [Rr] [T];
Ln: [Ll] [Nn];
Log: [Ll] [Oo] [Gg];
WS: [ \t\r\n]+ -> skip;
