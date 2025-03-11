
select * from tab;

delete from TBL_LEAVE
where fk_member_no = 189;

commit;

select *
from TBL_LEAVE

select *
from tbl_member

UPDATE tbl_member SET member_status = 1 WHERE  member_status = 0;


delete from tbl_member
where pk_member_no = 101;

commit;

desc tbl_member;

select *
from tbl_member
where member_user_id = ' ' and member_passwd = 'kakao';

select *
from tbl_product;

delete from tbl_member
where pk_mem_no = 6;

select *
from TBL_REGION

commit;

insert into tbl_member (pk_mem_no, mem_regdate, mem_user_id, mem_passwd, mem_tel, mem_passwd_change_date,mem_authorization , mem_point, mem_score,mem_status )
                    values(mem_seq.nextval, to_char(sysdate), 'admin', 'qwer1234$', '010-0101-0101', to_char(sysdate), 3,0, 0, 1);
                    

------------------------------------------------------------------------------------------------------------------------------
-- 회원테이블

create table tbl_member
(
pk_mem_no                 NUMBER                NOT NULL,
mem_regdate               DATE                  NOT NULL,
mem_user_id               VARCHAR2(20)          NOT NULL,
mem_passwd                VARCHAR2(200)         NOT NULL,
mem_tel                   VARCHAR2(100)         NOT NULL,
mem_passwd_change_date    DATE                  NOT NULL,
mem_authorization         NUMBER(1)             NOT NULL,
mem_point                 NUMBER                NOT NULL,
mem_score                 NUMBER    DEFAULT 0   NOT NULL,
mem_status                NUMBER(1) DEFAULT 1   NOT NULL 

CONSTRAINT mem_pk_mem_no PRIMARY KEY(pk_mem_no),
CONSTRAINT mem_uq_mem_user_id UNIQUE(mem_user_id),
CONSTRAINT mem_uq_mem_tel UNIQUE(mem_tel),
CONSTRAINT mem_ck_mem_authorization check(mem_authorization in(0,1,2,3,4,5))
CONSTRAINT mem_ck_mem_status check(mem_status in(0,1,2)) -- 0 : 탈퇴, 1 : 활성화, 2 : 정지지
);

CREATE SEQUENCE mem_seq;



select *
from tbl_member;

insert into tbl_inquire(pk_inquire_no, fk_member_no, inquire_title, inquire_content, inquire_status, inquire_secret, inquire_regdate)
        values(inquire_seq.nextval, 3, 'AA', 'AAA', default, default, default) 

COMMIT;

------------------------------------------------------------------------------------------------------------------------------
-- 메인페이지 이미지 테이블

create table tbl_main(
pk_main_seq           NUMBER         NOT NULL,
main_imgname       VARCHAR2(20)    NOT NULL,
main_imgfilename   VARCHAR2(200)    NOT NULL,
location_path       VARCHAR2(100)    NOT NULL,

CONSTRAINT main_pk_main_seq PRIMARY KEY(pk_main_seq)
);

CREATE SEQUENCE main_seq;


------------------------------------------------------------------------------------------------------------------------------
-- 문의 테이블

SELECT pk_inquire_no, fk_member_no, inquire_title, inquire_content, inquire_file_size, inquire_regdate,
    CASE 
        WHEN inquire_secret = 0 THEN '공개'
        WHEN inquire_secret = 1 THEN '비공개'
    END AS inquire_secret_status,    
    CASE 
        WHEN inquire_status = 0 THEN '미답변'
        WHEN inquire_status = 1 THEN '답변완료'
    END AS inquire_status_status
FROM tbl_inquire;



select *
from tbl_member

drop table tbl_inquire purge

select inquire_status
from tbl_inquire
where pk_inquire_no = 202

update tbl_inquire
	    set inquire_status = 0
	    where pk_inquire_no = 202
        
        commit;

create table tbl_inquire
(
pk_inquire_no          NUMBER                                 NOT NULL,
fk_member_no           NUMBER                                 NOT NULL,
inquire_title          NVARCHAR2(50)                          NOT NULL,
inquire_content        NVARCHAR2(2000)                        NOT NULL,
inquire_filename       VARCHAR2(255)                                  ,
inquire_orgfilename    VARCHAR2(255)                                  ,
inquire_file_size      NUMBER                                         ,
inquire_status         NUMBER(1)        default 0             NOT NULL,
inquire_secret         NUMBER(1)        default 0             NOT NULL,
inquire_regdate        DATE             default sysdate       NOT NULL,

CONSTRAINT inquire_pk_inquire_no PRIMARY KEY(pk_inquire_no),
CONSTRAINT inquire_fk_member_no FOREIGN KEY (fk_member_no) REFERENCES tbl_member(pk_member_no) ON DELETE CASCADE,
CONSTRAINT inquire_ck_inquire_status check(inquire_status in(0,1)),
CONSTRAINT inquire_ck_inquire_secret check(inquire_secret in(0,1))
);

CREATE SEQUENCE inquire_seq;


------------------------------------------------------------------------------------------------------------------------------
-- 질문 답변 테이블

drop table tbl_comment purge

create table tbl_comment
(
pk_com_no           NUMBER                                 NOT NULL,
fk_prt_con_no       NUMBER                                 NOT NULL,
fk_inq_no           NUMBER                                 NOT NULL,
fk_mem_no           NUMBER                                 NOT NULL,
com_group_no        NUMBER                                 NOT NULL,
com_depth_no        NUMBER                                 NOT NULL,
com_content         NVARCHAR2(2000)                        NOT NULL,
com_regdate         DATE           default sysdate         NOT NULL,
com_filename        VARCHAR2(255)                          NOT NULL,
com_orgfilename     VARCHAR2(255)                          NOT NULL,
com_filesize        NUMBER                                 NOT NULL,

CONSTRAINT comment_pk_com_no PRIMARY KEY(pk_com_no),
CONSTRAINT comment_fk_prt_con_no FOREIGN KEY (fk_prt_con_no) REFERENCES tbl_comment(pk_com_no) on delete cascade,
CONSTRAINT comment_fk_inq_no FOREIGN KEY (fk_inq_no) REFERENCES tbl_inquire(pk_inq_no) on delete cascade,
CONSTRAINT comment_fk_mem_no FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade
);

CREATE SEQUENCE comment_seq;

ALTER TABLE tbl_comment DROP COLUMN comment_title;

ALTER TABLE tbl_comment DROP CONSTRAINT comment_fk_prt_con_no;


ALTER TABLE tbl_comment DROP COLUMN comment_depth_no;

commit;

DELETE FROM tbl_comment;

select *
from tbl_comment
order by fk_parent_no desc

------------------------------------------------------------------------------------------------------------------------------
-- 공지사항 테이블

drop table tbl_notice purge

create table tbl_notice
(
pk_noti_no         NUMBER                                 NOT NULL,
fk_mem_no          NUMBER                                 NOT NULL,
noti_title         VARCHAR2(50)                           NOT NULL,
noti_content       NVARCHAR2(2000)                        NOT NULL,
noti_filename      VARCHAR2(255)                                  ,
noti_orgfilename   VARCHAR2(255)                                  ,
noti_filesize      NUMBER                                         ,
noti_views         NUMBER       default 0                 NOT NULL,
noti_date          DATE         default sysdate           NOT NULL,
noti_update_date   DATE         default sysdate           NOT NULL,                      

CONSTRAINT notice_pk_noti_no PRIMARY KEY(pk_noti_no),
CONSTRAINT notice_fk_mem_no FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) ON DELETE CASCADE
);

CREATE SEQUENCE notice_seq;

insert into tbl_notice(pk_notice_no, fk_member_no, notice_title, notice_content, notice_date, notice_views)
        values(notice_seq.nextval, 3, 'AA', 'AAA', default, default) 

commit;

------------------------------------------------------------------------------------------------------------------------------
-- 포인트 기록 테이블

drop table tbl_point_history purge;

create table tbl_point_history
(
pk_ph_no   NUMBER                                NOT NULL,
fk_mem_no   NUMBER                              NOT NULL,
ph_reason   VARCHAR2(50)                        NOT NULL,
ph_ch_point   NUMBER           default 0            NOT NULL,
ph_bf_point   NUMBER           default 0            NOT NULL,
ph_af_point   NUMBER           default 0            NOT NULL,
ph_regdate   DATE           default sysdate      NOT NULL,

CONSTRAINT ph_pk_ph_no PRIMARY KEY(pk_ph_no),
CONSTRAINT ph_fk_mem_no FOREIGN KEY(fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade
);


CREATE SEQUENCE point_history_seq;



------------------------------------------------------------------------------------------------------------------------------
-- 로그인 기록 테이블

create table tbl_loginhistory
(
pk_login_history       NUMBER                           NOT NULL,
fk_mem_no              NUMBER                           NOT NULL,
user_ip                VARCHAR2(20)                       NOT NULL,
login_date               DATE      default sysdate      NOT NULL,

CONSTRAINT lh_pk_login_history PRIMARY KEY(pk_login_history),
CONSTRAINT lh_fk_mem_no FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade
);

CREATE SEQUENCE login_history_seq;



------------------------------------------------------------------------------------------------------------------------------
-- 후기 테이블
--@#@#

drop table tbl_reivew purge

create table tbl_review 
(
    pk_rev_no           NUMBER                  NOT NULL, -- 후기 번호
    fk_mem_no           NUMBER                  NOT NULL, -- 회원번호
    fk_tra_no          NUMBER                   NOT NULL, -- 거래번호
    rev_content         NVARCHAR2(1000)         NOT NULL, -- 후기내용
    rev_regdate         DATE    DEFAULT SYSDATE NOT NULL, -- 작성일자
    rev_img_file_name   NVARCHAR2(300),                   -- 후기 사진 파일명
    rev_img_org_name    NVARCHAR2(300),                   -- 후기 사진명
    constraint review_pk_rev_no PRIMARY KEY(pk_rev_no),
    constraint review_fk_mem_no FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade,
    constraint review_fk_tra_no FOREIGN KEY (fk_tra_no) REFERENCES tbl_trade(pk_tra_no) on delete cascade
);

-- tbl_review pk sequence
create sequence review_seq;


------------------------------------------------------------------------------------------------------------------------------
-- 후기설문응답 테이블
create table tbl_survey_resp
(
    pk_sv_rp_no       NUMBER                  NOT NULL, -- 후기설문응답 번호
    fk_rev_no         NUMBER                  NOT NULL, -- 후기번호
    fk_sv_no          NUMBER                  NOT NULL, -- 후기설문문항 번호
    constraint survey_resp_pk_sv_rp_no PRIMARY KEY(pk_sv_rp_no),
    constraint survey_resp_fk_rev_no FOREIGN KEY (fk_rev_no) REFERENCES tbl_review(pk_rev_no) on delete cascade,
    constraint survey_resp_fk_sv_no FOREIGN KEY (fk_sv_no) REFERENCES tbl_survey(pk_sv_no) on delete cascade
);

-- tbl_survey_resp pk sequence
create sequence survey_resp_seq;

------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------
-- 후기설문 문항 테이블
create table tbl_survey
(
    pk_sv_no             NUMBER                  NOT NULL, -- 후기설문문항 번호
    sv_content           NUMBER                  NOT NULL, -- 설문문항
    constraint survey_pk_sv_no_const PRIMARY KEY(pk_sv_no)
)

-- tbl_survey pk sequence
create sequence survey_seq;



------------------------------------------------------------------------------------------------------------------------------
-- 사용자 차단 테이블
create table tbl_blackllist 
(
    pk_black_no         NUMBER                  NOT NULL, -- 사용자 차단번호
    fk_black_target_no  NUMBER                  NOT NULL, -- 차단대상 회원번호
    fk_mem_no           NUMBER                  NOT NULL, -- 차단하는 회원번호
    black_regdate       DATE    DEFAULT SYSDATE NOT NULL, -- 차단일자
    constraint blaklist_pk_black_no PRIMARY KEY(pk_black_no),
    constraint blaklist_fk_black_target_no FOREIGN KEY (fk_black_target_no) REFERENCES tbl_member(pk_mem_no) on delete cascade,
    constraint blaklist_fk_mem_no FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade
);

-- tbl_blacklist pk sequence
create sequence blacklist_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 찜 테이블


create table tbl_wish
(
pk_wish_no    NUMBER                 NOT NULL,
fk_prod_no   NUMBER                 NOT NULL,
fk_mem_no   NUMBER                 NOT NULL,

CONSTRAINT wish_pk_wish_no PRIMARY KEY (pk_wish_no),
CONSTRAINT wish_fk_prod_no FOREIGN KEY (fk_prod_no) REFERENCES tbl_product(pk_prod_no) on delete cascade,
CONSTRAINT wish_fk_mem_no FOREIGN KEY (fk_prod_no) REFERENCES tbl_member(pk_mem_no) on delete cascade
);

CREATE SEQUENCE wish_seq

--&&&&
------------------------------------------------------------------------------------------------------------------------------
-- 

select * from tab;

create table tbl_bid
(
pk_bid_no       NUMBER                           NOT NULL,
fk_mem_no       NUMBER                           NOT NULL,
fk_auc_no       NUMBER                           NOT NULL,
bid_price       NUMBER                           NOT NULL,
bid_regdate       DATE       default sysdate     NOT NULL,

CONSTRAINT bid_pk_bid_no PRIMARY KEY (pk_bid_no),
CONSTRAINT bid_fk_mem_no FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade,
CONSTRAINT bid_fk_auc_no FOREIGN KEY (fk_auc_no) REFERENCES tbl_auction(pk_auc_no) on delete cascade
);  


CREATE SEQUENCE bid_seq


------------------------------------------------------------------------------------------------------------------------------
-- 경매 테이블

create table tbl_auction
(
pk_auc_no          NUMBER                            NOT NULL,
fk_prod_no         NUMBER                            NOT NULL,
fk_win_mem_no      NUMBER                            NOT NULL,
auc_price          NUMBER(10)                                ,
auc_regdate        DATE         default sysdate      NOT NULL,
auc_enddate        DATE                              NOT NULL,

CONSTRAINT auction_pk_auc_no      PRIMARY KEY (pk_auc_no),
CONSTRAINT auction_fk_prod_no     FOREIGN KEY (fk_prod_no) REFERENCES tbl_product(pk_prod_no) on delete cascade,
CONSTRAINT auction_fk_win_mem_no  FOREIGN KEY (fk_win_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade
);


CREATE SEQUENCE auc_seq;
------------------------------------------------------------------------------------------------------------------------------
--상품 이미지테이블

create table tbl_prod_img
(
pk_pi_no       NUMBER                                NOT NULL,
fk_prod_no       NUMBER                                NOT NULL,
pi_name           VARCHAR2(300)                            NOT NULL,
pi_org_name       VARCHAR2(300)                            NOT NULL,
pi_is_tumnail   NUMBER        default 0               NOT NULL,
CONSTRAINT prod_img_pk_pi_no PRIMARY KEY (pk_pi_no),
CONSTRAINT prod_img_fk_prod_no FOREIGN KEY (fk_prod_no) REFERENCES tbl_product(pk_prod_no) on delete cascade,
CONSTRAINT prod_img_ck_pi_is_tumnail check(pi_is_tumnail in(0,1))
);

CREATE SEQUENCE pi_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 상품테이블

create table tbl_product
(
pk_prod_no           NUMBER                           NOT NULL,
fk_mem_no           NUMBER                           NOT NULL,
fk_rg_no       NUMBER                           NOT NULL,
fk_ct_no            NUMBER                           NOT NULL,
fk_ctd_no            NUMBER                           NOT NULL,
prod_name           NVARCHAR2(50)                   NOT NULL,
prod_contents       NVARCHAR2(2000)                   NOT NULL,
prod_price           NUMBER(10)                       NOT NULL,
prod_status           NUMBER(1)     default 0         NOT NULL,
prod_sale_status   NUMBER(1)     default 0         NOT NULL,
prod_regdate       DATE         default sysdate   NOT NULL,
prod_update           DATE         default sysdate   NOT NULL,
prod_sale_type       NUMBER(1)     default 0         NOT NULL,
prod_views              NUMBER     default 0         NOT NULL,

CONSTRAINT prod_pk_prod_no PRIMARY KEY (pk_prod_no),
CONSTRAINT prod_fk_mem_no  FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade,
CONSTRAINT prod_fk_rg_no  FOREIGN KEY (fk_rg_no) REFERENCES tbl_region(pk_rg_no) on delete cascade,
CONSTRAINT prod_fk_fk_ctd_no  FOREIGN KEY (fk_ctd_no) REFERENCES tbl_category_detail(pk_ctd_no) on delete cascade,
CONSTRAINT prod_ck_prod_status check(prod_status in(0,1)),
CONSTRAINT prod_ck_prod_sale_status check(prod_sale_status in(0,1,2,3,4,5)),
CONSTRAINT prod_ck_prod_sale_type check(prod_sale_type in(0,1))
);



CREATE SEQUENCE prod_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 지역 테이블

create table tbl_region
(
pk_rg_no     NUMBER                           NOT NULL,
rg_state     NVARCHAR2(30)                   NOT NULL,
rg_city      NVARCHAR2(30)                   NOT NULL,
rg_town      NVARCHAR2(30)                   NOT NULL,
rg_lat       NUMBER                           NOT NULL,
rg_lng       NUMBER                           NOT NULL,

CONSTRAINT region_pk_rg_no PRIMARY KEY (pk_rg_no)
);

CREATE SEQUENCE rg_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 충전 테이블


create table tbl_charge
(
pk_cha_no       NUMBER                               NOT NULL,
fk_user_no       NUMBER                               NOT NULL,
cha_price       NUMBER(10)                           NOT NULL,
cha_regdate    DATE           default sysdate     NOT NULL,
cha_commission   NUMBER(10)                           NOT NULL,

CONSTRAINT pk_cha_no_const PRIMARY KEY (pk_cha_no)
);

CREATE SEQUENCE cha_no;

------------------------------------------------------------------------------------------------------------------------------
-- 거래 테이블


create table tbl_trade
(
pk_tra_no       NUMBER                               NOT NULL,
fk_seller_no   NUMBER                               NOT NULL,
fk_consumer_no   NUMBER                               NOT NULL,
fk_prod_no       NUMBER                               NOT NULL,
tra_status       NUMBER(1)      default 1              NOT NULL,
tra_cancel_date   DATE                                ,
tra_pending_date    DATE                    ,
tra_confirm_date    DATE                    ,


CONSTRAINT tra_pk_tra_no PRIMARY KEY (pk_tra_no),
CONSTRAINT tra_fk_seller_no FOREIGN KEY (fk_seller_no) REFERENCES tbl_member(pk_mem_no) on delete cascade,
CONSTRAINT tra_fk_consumer_no FOREIGN KEY (fk_consumer_no) REFERENCES tbl_member(pk_mem_no) on delete cascade,
CONSTRAINT tra_fk_prod_no FOREIGN KEY (fk_prod_no) REFERENCES tbl_product(pk_prod_no) on delete cascade,
CONSTRAINT tra_ck_tra_status check(tra_status in(0,1,2))
);

CREATE SEQUENCE tra_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 은행 테이블

create table tbl_bank
(
pk_bank_no   NUMBER                                   NOT NULL,
bank_name   NVARCHAR2(10)                           NOT NULL,

CONSTRAINT pk_bank_no_const PRIMARY KEY (pk_bank_no),
CONSTRAINT bank_ck_bank_name check(bank_name in(0,1,2,3,4))
)

CREATE SEQUENCE bank_no;

------------------------------------------------------------------------------------------------------------------------------
-- 환급 테이블

create table tbl_refund
(
pk_refu_no       NUMBER                           NOT NULL,
fk_acc_no       NUMBER                           NOT NULL,
fk_mem_no       NUMBER                           NOT NULL,
refu_price       NUMBER                           NOT NULL,
refu_regdate   DATE       default sysdate     NOT NULL,

CONSTRAINT refund_pk_refu_no PRIMARY KEY (pk_refu_no),
CONSTRAINT refund_fk_acc_no FOREIGN KEY (fk_acc_no) REFERENCES tbl_account(pk_acc_no) on delete cascade,
CONSTRAINT refund_fk_mem_no FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade
);

CREATE SEQUENCE refu_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 카테고리 조회 기록 테이블


create table tbl_search_category_history
(
pk_sch_no   NUMBER                                   NOT NULL,
fk_user_no       NUMBER                                   NOT NULL,
fk_ctd_no       NUMBER                                  NOT NULL,
sch_date       DATE     default sysdate       NOT NULL,

CONSTRAINT sch_pk_sch_no PRIMARY KEY (pk_sch_no),
CONSTRAINT sch_fk_user_no FOREIGN KEY (fk_user_no) REFERENCES tbl_member(pk_mem_no) on delete cascade,
CONSTRAINT sch_fk_ctd_no FOREIGN KEY (fk_ctd_no)REFERENCES tbl_category_detail(pk_ctd_no)  on delete cascade
);



CREATE SEQUENCE search_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 카테고리 하위 테이블

create table tbl_category_detail
(
pk_ctd_no   NUMBER                               NOT NULL,
fk_ct_no   NUMBER                               NOT NULL,
ctd_name   NVARCHAR2(20)                       NOT NULL,

CONSTRAINT ctd_pk_ctd_no PRIMARY KEY (pk_ctd_no),
CONSTRAINT ctd_fk_ct_no FOREIGN KEY (fk_ct_no) REFERENCES tbl_category(pk_ct_no)
);

CREATE SEQUENCE ctd_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 상위 카테고리

create table tbl_category
(
pk_ct_no   NUMBER                                   NOT NULL,
ct_name    NVARCHAR2(20)                            NOT NULL,

CONSTRAINT category_pk_ct_no PRIMARY KEY (pk_ct_no)
);


CREATE SEQUENCE ct_seq;

------------------------------------------------------------------------------------------------------------------------------
-- 은행 테이블

create table tbl_account
(
pk_acc_no   NUMBER                                   NOT NULL,
fk_bank_no   NUMBER                                   NOT NULL,
fk_mem_no   NUMBER                                 NOT NULL,

CONSTRAINT account_pk_acc_no PRIMARY KEY (pk_acc_no),
CONSTRAINT account_fk_bank_no FOREIGN KEY (fk_bank_no) REFERENCES tbl_bank(pk_bank_no) on delete cascade,
CONSTRAINT account_fk_mem_no FOREIGN KEY (fk_mem_no) REFERENCES tbl_member(pk_mem_no) on delete cascade
);

CREATE SEQUENCE acc_seq;

select * from tab;

select * 
from tbl_loginhistory

show user;


select *
from tbl_region
where region_lat = 37.5586816


ALTER TABLE tbl_member 
MODIFY member_user_id  VARCHAR(50);

ALTER TABLE tbl_member 
ADD member_oauth_type varchar2(30) NULL;

select *
from tbl_member;

UPDATE tbl_member
SET member_name = '최재혁'
WHERE pk_member_no = 102;

commit;

delete from tbl_member
where pk_member_no = 188;


desc tbl_member;


select *
from tbl_loginhistory;

update tbl_loginhistory
set login_history_date = to_date('25/03/01')
where fk_member_no = 61;


