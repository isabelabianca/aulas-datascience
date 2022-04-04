set serveroutput on
set verify off

declare
    v_salario       number(10,2):= &v_salario;
    v_salario_final number(10,2);
begin
    if v_salario <= 1513.69 then
        v_salario_final := v_salario;
    elsif v_salario >= 1513.70 and v_salario <= 2725.12 then
        v_salario_final := v_salario  - (v_salario * 0.16);
    else
        v_salario_final := v_salario - (v_salario * 0.285);
    end if;
    dbms_output.put_line('Salário final: R$ '||v_salario_final);
end;


create table aluno2 (
    ra          number(10) primary key,
    nome        varchar2(50),
    nota        number(4,2),
    media       number(4,2),
    situacao    varchar2(10)
);

begin 
    insert into aluno2 values (88495, 'Mel', 10, null, null);
    insert into aluno2 values (5654, 'Isis', 9.5, null, null);
end;
declare 
    v_ra        number(10):= &ra;
    v_nota      number(4,2);
    v_situacao  varchar2(10);
begin
    select nota into v_nota from aluno2 where ra = v_ra;
    if v_nota > 6 then
        v_situacao := 'Aprovado';
    else
        v_situacao := 'Reprovado';
    end if;
    update aluno2 set media = v_nota, situacao = v_situacao where ra = v_ra;
    commit;
end;

select * from aluno2
