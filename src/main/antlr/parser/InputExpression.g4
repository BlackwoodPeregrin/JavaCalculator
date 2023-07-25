grammar InputExpression;

options {
    language = Java;
}

@header {
package antrl.gen;
}


expression: unaryOperator? expr (operator unaryOperator? expr)*;

expr: function | number | lBrecket expression rBrecket;

function: fun lBrecket expression rBrecket;

fun: Sin | Cos | Tan | Asin | Acos | Atan | Sqrt | Ln | Log;
operator: Plus | Minus | Mult | Div | Mod | Pow;
unaryOperator: Plus | Minus;
number: Number;
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
Sqrt: [Ss] [Qq] [Rr] [Tt];
Ln: [Ll] [Nn];
Log: [Ll] [Oo] [Gg];
WS: [ \t\r\n]+ -> skip;
