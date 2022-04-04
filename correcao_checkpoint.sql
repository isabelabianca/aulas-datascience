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
    situacao    varchar2(10),
    faltas      number(3),
    c_horaria   number(3)
);

begin 
    insert into aluno2 values (10, 'Mel', 10, null, null, null, null);
    insert into aluno2 values (11, 'Isis', 9.5, null, null, null, null);
    insert into aluno2 values (12, 'Jurema', 5.5, null, null, null, null);
    insert into aluno2 values (13, 'Babi', 7.5, null, null, null, null);
    insert into aluno2 values (14, 'Noé', 2, null, null, null, null);
end;
declare 
    v_ra        number(10):= &ra;
    v_nota      number(4,2);
    v_situacao  varchar2(10);
    v_media     number(4,2);
    v_faltas    number(3);
    v_c_hora    number(3);
begin
    select nota, media, faltas, c_horaria into v_nota, v_media, v_faltas, v_c_hora from aluno2 where ra = v_ra;
    
    update aluno2 set media = v_nota where ra = v_ra;
    
    if v_media > 6 and v_faltas <= v_c_hora * 0.25 then
        v_situacao := 'Aprovado';
    elsif v_media > 6 and v_faltas > v_c_hora * 0.25 then
        v_situacao := 'Reprovado por faltas';
    elsif v_media <= 6 and v_faltas <= v_c_hora * 0.25 then
        v_situacao := 'Reprovado por nota';    
    else
        v_situacao := 'Reprovado por nota e falta';   
    end if;
    commit;
    
    
end;

select * from aluno2
