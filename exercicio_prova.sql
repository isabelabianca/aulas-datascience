set serveroutput on
set verify off

create table t_conta_corrente (
    nr_conta        number(10),
    nm_correntista  varchar2(50),
    ds_saldo        number(10,2),
    ds_tipo_conta   number(1)
);

begin
    insert into t_conta_corrente values(1, 'Isis', 1000, 0);
    insert into t_conta_corrente values(2, 'Noé', 2000, 0);
    insert into t_conta_corrente values(3, 'Barbara', 3000, 1);
end;

declare
    v_saldo         number(10,2);
    v_tipo_conta    number(1);
    v_nr_conta      number(10):= &v_nr_conta;
    v_saque         number(10,2):= &v_saque;
begin
    select ds_saldo, ds_tipo_conta into v_saldo, v_tipo_conta from t_conta_corrente where nr_conta = v_nr_conta;
    if(v_tipo_conta = 1) then
        v_saldo := v_saldo * 1.1;
        v_saldo := v_saldo - v_saque;
    elsif (v_saque > v_saldo) then
        dbms_output.put_line('Saldo insuficiente!');
    else
        v_saldo := v_saldo - v_saque;          
    end if; 
    update t_conta_corrente set ds_saldo = v_saldo where nr_conta = v_nr_conta;
    commit;
end;

select * from t_conta_corrente;

declare
    v_dias           number(2):= &v_qt_dias;
    v_estadia        number(10,2);
    v_convenio       number(1):= &v_convenio;
begin
    if (v_dias = 1) then
        v_estadia := v_dias *15;
    elsif(v_dias = 2 or v_dias = 3) then
        v_estadia := v_dias * 10;
    elsif (v_dias >= 4 and v_dias <=7) then
        v_estadia := v_dias * 8;
    elsif(v_dias > 7) then
        v_estadia := v_dias * 5;
    end if;
    if (v_convenio = 1) then
        v_estadia := v_estadia * 0.85;
    end if;
    dbms_output.put_line('Valor a pagar: R$ ' || v_estadia);
end;

















