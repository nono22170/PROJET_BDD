-- TREUST Nolwenn
-- ZALLOT Tristan
-- Groupe F12
-- create schema matski_update;
set schema 'matski_update';

drop table if exists _ARTICLE cascade ;

drop table if exists _CATEGORIE   cascade ;

drop table if exists _SE_DECOMPOSE   cascade ;

drop table if exists _CLIENT cascade ;

drop table if exists _CONTACT cascade ;

drop table if exists _COMMANDE cascade ;

drop table if exists _DETAILCOMMANDE cascade ;

drop table if exists _ETIQUETTE cascade ;

drop table if exists _LISTEPRIX cascade ;

drop table if exists _TARIFVENTE cascade ;

drop table if exists _TYPEARTICLE cascade ;

/*==============================================================*/
/* Table : ARTICLE                                              */
/*==============================================================*/
create table _ARTICLE (
   NUMARTICLE           SERIAL               not null,
   NUMCATEGORIE         INTEGER              not null,
   CODETYPE             CHAR(1)              not null,
   NOMARTICLE           VARCHAR(50)          not null,
   REFERENCEINTERNE     CHAR(10)             not null,
   CODEBARRE            CHAR(13)             not null,
   COUTACHAT            NUMERIC(10,2)        not null,
   constraint PK__ARTICLE primary key (NUMARTICLE)
);

insert into
     matski_update._ARTICLE(NUMCATEGORIE,CODETYPE,NOMARTICLE,REFERENCEINTERNE,CODEBARRE,COUTACHAT)
   select NUMCATEGORIE,CODETYPE,NOMARTICLE,REFERENCEINTERNE,CODEBARRE,COUTACHAT
   from matski.ARTICLE ; 

/*==============================================================*/
/* Table : CATEGORIE                                            */
/*==============================================================*/
create table _CATEGORIE (
   NUMCATEGORIE         SERIAL               not null,
   LIBELLECATEGORIE     VARCHAR(40)          not null,
   constraint PK__CATEGORIE primary key (NUMCATEGORIE)
);

insert into
     matski_update._CATEGORIE(NUMCATEGORIE,LIBELLECATEGORIE)
   select NUMCATEGORIE,LIBELLECATEGORIE
   from matski.CATEGORIE ; 

/*==============================================================*/
/* Table : SE_DECOMPOSE                                         */
/*==============================================================*/
create table _SE_DECOMPOSE (
   NUMCATEGORIE         INTEGER              not null,
   CAT_NUMCATEGORIE2    INTEGER              not null,
   constraint PK__SE_DECOMPOSE primary key (NUMCATEGORIE)
);

insert into
     matski_update._SE_DECOMPOSE(NUMCATEGORIE,CAT_NUMCATEGORIE2)
   select NUMCATEGORIE,CAT_NUMCATEGORIE2
   from matski.CATEGORIE 
   where CAT_NUMCATEGORIE2 is not null ; 


/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
create table _CLIENT (
   NUMCLIENT            SERIAL               not null,
   CODELISTE            CHAR(1)              not null,
   CODEETIQUETTE        CHAR(2)              not null,
   NOMCLIENT            VARCHAR(50)          not null,
   ADRESSERUECLIENT     VARCHAR(50)          not null,
   ADRESSECODEPOSTALCLIENT VARCHAR(10)       not null,
   ADRESSEVILLECLIENT   VARCHAR(40)          not null,
   ADRESSEPAYSCLIENT    VARCHAR(30)          not null,
   TELEPHONECLIENT      VARCHAR(12)          not null,
   MAILCLIENT           VARCHAR(60)          not null, 
   constraint PK__CLIENT primary key (NUMCLIENT)
);

insert into
     matski_update._CLIENT(CODELISTE, CODEETIQUETTE , NOMCLIENT ,ADRESSERUECLIENT, ADRESSECODEPOSTALCLIENT , ADRESSEVILLECLIENT, ADRESSEPAYSCLIENT ,
   TELEPHONECLIENT, MAILCLIENT)
   select CODELISTE, CODEETIQUETTE , NOMCLIENT ,ADRESSERUECLIENT, ADRESSECODEPOSTALCLIENT , ADRESSEVILLECLIENT, ADRESSEPAYSCLIENT ,
   TELEPHONECLIENT, MAILCLIENT
   from matski.CLIENT ;

/*==============================================================*/
/* Table : CONTACT                                              */
/*==============================================================*/
create table _CONTACT (
  NUMCONTACT            SERIAL               not null,
  NOMCONTACT            VARCHAR(50)          not null,
  TELEPHONECONTACT      VARCHAR(12)          not null,
  FONCTIONCONTACT       VARCHAR(20)          not null,
  NUMCLIENT             INTEGER              not null,
  constraint PK__CONTACT primary key (NUMCONTACT)
) ;

insert into
     matski_update._CONTACT(NOMCONTACT,TELEPHONECONTACT,FONCTIONCONTACT,NUMCLIENT)
   select NOMCONTACT1,TELEPHONECONTACT1, FONCTIONCONTACT1,NUMCLIENT
   from matski.CLIENT ;
   
insert into
     matski_update._CONTACT(NOMCONTACT,TELEPHONECONTACT,FONCTIONCONTACT,NUMCLIENT)
   select NOMCONTACT2,TELEPHONECONTACT2, FONCTIONCONTACT2,NUMCLIENT
   from matski.CLIENT 
   where NOMCONTACT2 is not null ;

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table _COMMANDE (
   NUMCOMMANDE          SERIAL               not null,
   NUMCLIENT            INTEGER              not null,
   DATECOMMANDE         DATE                 not null,
   MONTANTFRAIS         NUMERIC(10,2)        not null,
   MONTANTHT            NUMERIC(10,2)        not null,
   MONTANTTTC           NUMERIC(10,2)        not null,
   constraint PK__COMMANDE primary key (NUMCOMMANDE)
);

insert into
     matski_update._COMMANDE
   select *
   from matski.COMMANDE ; 

/*==============================================================*/
/* Table : DETAILCOMMANDE                                       */
/*==============================================================*/
create table _DETAILCOMMANDE (
   NUMCOMMANDE          INTEGER                 not null,
   NUMARTICLE           INTEGER                 not null,
   QUANTITECOMMANDEE    INTEGER                 not null,
   QUANTITELIVREE       INTEGER                 not null,
   constraint PK__DETAILCOMMANDE primary key (NUMCOMMANDE, NUMARTICLE)
);

insert into
     matski_update._DETAILCOMMANDE
   select *
   from matski.DETAILCOMMANDE ; 

/*==============================================================*/
/* Table : ETIQUETTE                                            */
/*==============================================================*/
create table _ETIQUETTE (
   CODEETIQUETTE        CHAR(3)              not null,
   LIBELLEETIQUETTE     VARCHAR(70)          not null,
   CODETYPETVA          INTEGER		           not null,
   constraint PK__ETIQUETTE primary key (CODEETIQUETTE)
);

insert into
     matski_update._ETIQUETTE
   select *
   from matski.ETIQUETTE ; 

/*==============================================================*/
/* Table : LISTEPRIX                                            */
/*==============================================================*/
create table _LISTEPRIX (
   CODELISTE            CHAR(1)              not null,
   LIBELLELISTE         VARCHAR(20)          not null,
   constraint PK__LISTEPRIX primary key (CODELISTE)
);

insert into
     matski_update._LISTEPRIX
   select *
   from matski.LISTEPRIX ; 


/*==============================================================*/
/* Table : TARIFVENTE                                           */
/*==============================================================*/
create table _TARIFVENTE (
   NUMARTICLE           INTEGER              not null,
   CODELISTE            CHAR(1)              not null,
   PRIXVENTE            DECIMAL(10,2)        not null,
   constraint PK__TARIFVENTE primary key (NUMARTICLE)
);

insert into
     matski_update._TARIFVENTE
   select *
   from matski.TARIFVENTE ; 

/*==============================================================*/
/* Table : TYPEARTICLE                                          */
/*==============================================================*/
create table _TYPEARTICLE (
   CODETYPE             CHAR(1)              not null,
   LIBELLETYPE          VARCHAR(40)          not null,
   constraint PK__TYPEARTICLE primary key (CODETYPE)
);

insert into
     matski_update._TYPEARTICLE
   select CODETYPE,LIBELLETYPE
   from matski.TYPEARTICLE ; 

alter table _ARTICLE
   add constraint FK_ARTICLE_ESTLIE_TYPEARTI foreign key (CODETYPE)
      references _TYPEARTICLE (CODETYPE);

alter table _ARTICLE
   add constraint FK_ARTICLE_FAITPARTI_CATEGORI foreign key (NUMCATEGORIE)
      references _CATEGORIE (NUMCATEGORIE);

alter table _SE_DECOMPOSE
   add constraint FK_SEDECOMPO_CATEGORI foreign key (CAT_NUMCATEGORIE2)
      references _CATEGORIE (NUMCATEGORIE);

alter table _SE_DECOMPOSE
   add constraint FK_SEDECOMPO2_CATEGORI foreign key (NUMCATEGORIE)
      references _CATEGORIE (NUMCATEGORIE);

alter table _CLIENT
   add constraint FK_CLIENT_DISPOSE_LISTEPRI foreign key (CODELISTE)
      references _LISTEPRIX (CODELISTE);

alter table _CLIENT
   add constraint FK_CLIENT_REGROUPE_ETIQUETT foreign key (CODEETIQUETTE)
      references _ETIQUETTE (CODEETIQUETTE);
      
alter table _CONTACT
   add constraint FK_CONTACT_REPRESENTE_CLIENT foreign key (NUMCLIENT)
      references _CLIENT (NUMCLIENT);

alter table _COMMANDE
   add constraint FK_COMMANDE_APPARTIEN_CLIENT foreign key (NUMCLIENT)
      references _CLIENT (NUMCLIENT);

alter table _DETAILCOMMANDE
   add constraint FK_DETAILCO_DETAILCOM_COMMANDE foreign key (NUMCOMMANDE)
      references _COMMANDE (NUMCOMMANDE);

alter table _DETAILCOMMANDE
   add constraint FK_DETAILCO_DETAILCOM_ARTICLE foreign key (NUMARTICLE)
      references _ARTICLE (NUMARTICLE);

alter table _TARIFVENTE
   add constraint FK_TARIFVEN_TARIFVENT_ARTICLE foreign key (NUMARTICLE)
      references _ARTICLE (NUMARTICLE);

alter table _TARIFVENTE
   add constraint FK_TARIFVEN_TARIFVENT_LISTEPRI foreign key (CODELISTE)
      references _LISTEPRIX (CODELISTE);

