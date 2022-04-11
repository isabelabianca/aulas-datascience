Crie em PL/SQL os programas:
Dado um salário X calcule o salário líquido, sendo que os descontos de IRPF 
ocorrem conforme a tabela abaixo:
Base de cálculo mensal em R$ Alíquota %
Até 1.513,69 (inclusive) -
De 1.513,70 até 2.725,12 (inclusive) 16,0
Acima de 2.725,12 28,5

set serveroutput on
set verify off

declare
    v_sal number(10,2) := &salario;
begin
    if v_sal <= 1513.69 then
        dbms_output.put_line(' sem desconto: '|| v_sal);
    elsif v_sal >= 1513.70 and v_sal <= 2725.12 then
        v_sal := v_sal - (v_sal * 0.16);
        dbms_output.put_line('16% de desconto: '|| v_sal);
    else
        v_sal := v_sal - (v_sal * 0.285);
        dbms_output.put_line('28,5% de desconto: '|| v_sal);
    end if;
end;

Criar uma tabela com nome Aluno com as colunas Ra, nome, nota, média e 
situação. 
Criar um bloco para incluir 3 linhas na tabela sem preencher os dados na 
coluna média e situação.
A situação do aluno deverá ser alimentada por um bloco de programação 
onde o usuário irá digitar o Ra do aluno e o mesmo irá preencher a situação 
da seguinte forma:
- Se a nota for maior que 6 “Aprovado”, se for menor “Reprovado”, 
gravar a média e a situação na tabela aluno

Atualizando o exercício
incluir na tabela as colunas faltas e c_hora, iuncluir dados para estas novas
colunas, por exemplo:
linha 1: faltas 3, c_hora 100.
linha 2: faltas 13, c_hora 100.
linha 3: faltas 90, c_hora 100.

situação:
média > 6 e faltas <= que 25% da carga horária: "Aprovado"
média > 6 e faltas > que 25% da carga horária: "Rep por faltas"
média <= 6 e faltas <= que 25% da carga horária: "Rep. por nota"
média <= 6 e faltas > que 25% da carga horária: "Rep. Nota e Falta"

drop table aluno

create table aluno (ra number(2) primary key,
                    nome varchar2(30),
                    nota number(4,2),
                    media number(4,2),
                    situacao varchar2(30));
                    
begin
    insert into aluno values(1, 'marcel', 10, null, null);
    insert into aluno values(2, 'Vanessa', 6, null, null);
    insert into aluno values(3, 'claudio', 3, null, null);
end;

declare
    v_ra number(2) := &ra;
    v_nota number(4,2);
    v_situa varchar2(30);
begin
    select nota into v_nota from aluno where ra = v_ra;
    if v_nota > 6 then
        v_situa := 'Aprovado';
        --dbms_output.put_line (v_ra||' - '||v_nota||' - '||v_situa);
    else
        v_situa := 'Reprovado';
        --dbms_output.put_line (v_ra||' - '||v_nota||' - '||v_situa);
    end if;
    update aluno set media = v_nota, situacao = v_situa where ra = v_ra;
    commit;
end;





select * from aluno
                    