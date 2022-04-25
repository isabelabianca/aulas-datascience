set serveroutput on;
create table t_funcionario (
    cd_fun      number(3),
    nm_fun      varchar2(50),
    salario     number(10,2),
    dt_adm      date
);

begin
    insert into t_funcionario values (1, 'Chris', 10000, to_date('17/04/2000', 'dd/mm/yyyy'));
    insert into t_funcionario values (2, 'Drew', 16000, to_date('02/10/1998', 'dd/mm/yyyy'));
    insert into t_funcionario values (3, 'Tonya', 5500, to_date('10/07/2010', 'dd/mm/yyyy'));   
    insert into t_funcionario values (4, 'Julius', 7300, to_date('08/06/2015', 'dd/mm/yyyy'));
    commit;
end;

declare 
    cursor c_exibe is select nm_fun, salario from t_funcionario;
    v_exibe c_exibe%rowtype;
begin
    open c_exibe;
    loop
        fetch c_exibe into v_exibe;
    exit when c_exibe%notfound;
    dbms_output.put_line('Nome: '||v_exibe.nm_fun||' - Salário: '||v_exibe.salario);
    end loop;
    close c_exibe;
end;

-- Mesmo resultado, utilizando o for
declare 
    cursor c_exibe is select * from t_funcionario;    
begin
    for v_exibe in c_exibe loop
    dbms_output.put_line('Nome: '||v_exibe.nm_fun||' - Salário: '||v_exibe.salario);
    end loop;
end;

-- Adicionando coluna na tabela
ALTER TABLE t_funcionario ADD tempo number(10);
commit;

declare 
    cursor c_exibe is select * from t_funcionario;
begin
    for v_exibe in c_exibe loop
        update t_funcionario set tempo = sysdate - v_exibe.dt_adm where cd_fun = v_exibe.cd_fun;
    end loop;
end;
