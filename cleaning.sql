# DDL and DML

## 1. Loan data fact table (for dashboards)
CREATE TABLE loan_fact AS
SELECT  issue_d, loan_status, loan_amnt, 
		term, int_rate, grade, sub_grade, annual_inc, dti, 
        emp_length, home_ownership, verification_status, addr_state,
        open_acc, revol_util, pub_rec_bankruptcies, mort_acc,
        total_pymnt, total_rec_int, total_rec_prncp, recoveries
FROM loan;


ALTER TABLE `lending_club`.`loan_fact` 
CHANGE COLUMN `issue_d` `issue_d` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `loan_status` `loan_status` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `term` `term` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `grade` `grade` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `sub_grade` `sub_grade` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `emp_length` `emp_length` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `home_ownership` `home_ownership` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `verification_status` `verification_status` VARCHAR(50) NULL DEFAULT NULL ,
CHANGE COLUMN `addr_state` `addr_state` VARCHAR(50) NULL DEFAULT NULL ;

alter table loan_fact add index emp_idx(emp_length); 
update loan_fact set emp_length = 0	where emp_length like "< 1 year%"	;
update loan_fact set emp_length = 1	where emp_length like "%1 year%"	;
update loan_fact set emp_length = 2 	where emp_length like "%2 years%"	;
update loan_fact set emp_length = 3 	where emp_length like "%3 years%"	;
update loan_fact set emp_length = 4	where emp_length like "%4 years%"	;
update loan_fact set emp_length = 5	where emp_length like "%5 years%"	;
update loan_fact set emp_length = 6 	where emp_length like "%6 years%"	;
update loan_fact set emp_length = 7 	where emp_length like "%7 years%"	;
update loan_fact set emp_length = 8 	where emp_length like "%8 years%"	;
update loan_fact set emp_length = 9 	where emp_length like "%9 years%"	;
update loan_fact set emp_length = 10 	where emp_length like "10+%"	;
update loan_fact set emp_length = null 	where emp_length like "%n/a%" or emp_length = ''	;

alter table loan_fact modify column emp_length int;


## 2. Loan data for ML classification

drop table loan_logreg1;
drop table loan_logreg_unfiltered1;
CREATE TABLE loan_logreg1 AS
SELECT
    loan_status, loan_amnt, term, purpose, int_rate, grade, initial_list_status, application_type, #loan terms
    emp_length, home_ownership, annual_inc, verification_status, addr_state, #borrower profile
    earliest_cr_line, issue_d, delinq_2yrs, inq_last_6mths, pub_rec, #credit history
    pub_rec_bankruptcies, total_acc, mort_acc,
    dti, open_acc, revol_bal, revol_util, acc_now_delinq,
    tot_coll_amt, tot_cur_bal, mths_since_last_delinq, mths_since_last_record, mths_since_recent_inq, mths_since_recent_bc_dlq, mths_since_last_major_derog, mths_since_rcnt_il, 
    all_util, avg_cur_bal, bc_open_to_buy, bc_util, il_util, inq_fi, inq_last_12m, pct_tl_nvr_dlq, tax_liens, tot_hi_cred_lim, total_bal_il, total_cu_tl, total_il_high_credit_limit, total_rev_hi_lim,
    num_actv_bc_tl, num_bc_tl, num_sats, num_tl_op_past_12m
    

FROM loan where loan_status in ('Fully Paid', 'Default', 'Charged Off');

ALTER TABLE `lending_club`.`loan_logreg1` 
	CHANGE COLUMN `term` `term` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `emp_length` `emp_length` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `home_ownership` `home_ownership` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `verification_status` `verification_status` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `purpose` `purpose` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `addr_state` `addr_state` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `earliest_cr_line` `earliest_cr_line` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `revol_util` `revol_util` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `initial_list_status` `initial_list_status` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `application_type` `application_type` VARCHAR(50) NULL DEFAULT NULL ,
	CHANGE COLUMN `loan_status` `loan_status` VARCHAR(100) NULL DEFAULT NULL,
    CHANGE COLUMN `issue_d` `issue_d` VARCHAR(50) NULL DEFAULT NULL,
add column credit_hist_months int;

### creating outcome variable
alter table loan_logreg1 add column is_default tinyint(1) after loan_status; 
alter table loan_logreg1 add index idx_def(loan_status); ### index for optimization
update loan_logreg1 set is_default = case 
	when loan_status like 'Charged Off%' or loan_status like 'Default%' then 1 
    when loan_status like 'Fully Paid' then 0 
    else null 
    end;     
alter table loan_logreg1 drop column loan_status;

### encoding verification status
alter table loan_logreg1 add column verif_status tinyint(2) after verification_status;
alter table loan_logreg1 add index idx_verif(verification_status);
update loan_logreg1 set verif_status = case 
	when verification_status like 'Verified%' then 2 
	when verification_status like 'Source%' then 1 
	else 0 
	end;
 

### encoding employment length into numerical  
alter table loan_logreg1 add index emp_idx(emp_length);
	update loan_logreg1 set emp_length = 0	where emp_length like "< 1 year%"	;
	update loan_logreg1 set emp_length = 1	where emp_length like "%1 year%"	;
	update loan_logreg1 set emp_length = 2 	where emp_length like "%2 years%"	;
	update loan_logreg1 set emp_length = 3 	where emp_length like "%3 years%"	;
	update loan_logreg1 set emp_length = 4	where emp_length like "%4 years%"	;
	update loan_logreg1 set emp_length = 5	where emp_length like "%5 years%"	;
	update loan_logreg1 set emp_length = 6 	where emp_length like "%6 years%"	;
	update loan_logreg1 set emp_length = 7 	where emp_length like "%7 years%"	;
	update loan_logreg1 set emp_length = 8 	where emp_length like "%8 years%"	;
	update loan_logreg1 set emp_length = 9 	where emp_length like "%9 years%"	;
	update loan_logreg1 set emp_length = 10 	where emp_length like "10+%"	;
	update loan_logreg1 set emp_length = null 	where emp_length like "%n/a%" or emp_length = ''	;
alter table loan_logreg1 modify emp_length int;

### calculate credit history total before loan in months 
update loan_logreg1 set credit_hist_months = timestampdiff(month, 
		str_to_date(concat('01-', earliest_cr_line), '%d-%b-%Y'), ### earliest credit
		str_to_date(concat('01-', issue_d), '%d-%b-%Y')); ### latest credit
        
### dropping date fields
alter table loan_logreg1 drop column earliest_cr_line, drop column issue_d;

### encoding binary fields
	# 1. application type
	update loan_logreg1 set application_type = case when application_type like 'joint%' then 1 else 0 end;
	alter table loan_logreg1 change application_type is_joint_application tinyint(1);

	# 2. initial list status
	update loan_logreg1 set initial_list_status = case when initial_list_status like '%w%' then 1 else 0 end;
	alter table loan_logreg1 change initial_list_status is_whole_offer tinyint(1);
	
    # 3. term
	update loan_logreg1 set term = case when term like '%60%' then 1 else 0 end;
	alter table loan_logreg1 change term is_term_sixty tinyint(1);
