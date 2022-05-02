-- CheckPoint 2 - Cursores

-- Exercício 1

CREATE TABLE PRODUTO (
    CODIGO NUMBER(4),
    CATEGORIA CHAR(1),
    VALOR NUMBER(4,2)
);

INSERT INTO PRODUTO VALUES (1001,'A',7.55);
INSERT INTO PRODUTO VALUES (1002,'B',5.95);
INSERT INTO PRODUTO VALUES (1003,'C',3.45);

declare
    cursor c_produto is select * from produto;
begin
    for i_produto in c_produto loop
        if (i_produto.categoria = 'A') then
            update produto set valor = i_produto.valor * 1.05 where codigo = i_produto.codigo;
        elsif(i_produto.categoria = 'B') then
            update produto set valor = i_produto.valor * 1.1 where codigo = i_produto.codigo;
        else
            update produto set valor = i_produto.valor * 1.15 where codigo = i_produto.codigo;
        end if;
    end loop;
end;

-- Exercício 2

create table aluno (
    ra number(2) primary key, 
    nome varchar(20), 
    A1 number(4,2), 
    A2 number(4,2), 
    A3 number(4,2), 
    A4 number(4,2), 
    media number(4,2),
    resultado varchar(15)
);

begin
    insert into aluno values (12, 'Roberto', 6, 4, 6, 4, null, null);
    insert into aluno values (23, 'Thiago', 5.5, 5, 6, 5, null, null);
    insert into aluno values (34, 'Bruna', 10, 8, 7.5, 9, null, null);
    insert into aluno values (45, 'Débora', 9, 6, 10, 9.5, null, null);
end;

declare
    cursor c_aluno is select * from aluno;
    v_media number(4,2);
    maior_nota  number(4,2);
begin
    for i_aluno in c_aluno loop
        if(i_aluno.a1 > i_aluno.a2) then
            maior_nota := i_aluno.a1;
        else
            maior_nota := i_aluno.a2;
        end if;
        v_media := (maior_nota + i_aluno.a3 + i_aluno.a4) / 3;
        if (v_media < 6) then
            update aluno set resultado = 'REPROVADO', media = v_media where ra = i_aluno.ra;
        else
            update aluno set resultado = 'APROVADO', media = v_media where ra = i_aluno.ra;
        end if;
    end loop;
end;

select * from aluno;