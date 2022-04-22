-- TREUST Nolwenn
-- ZALLOT Tristan
-- Groupe F12

set schema 'matski_update';

-- 1. L'ensemble des articles n'ayant jamais été commandé
-- ARTICLES JAMAIS COMMANDES
select *
from _ARTICLE
except 
select _ARTICLE.*
from _DETAILCOMMANDE natural join _ARTICLE ; 

-- 2. L'ensemble des catégories dans lesquelles il n'y a jamais eu de commandes
-- CATEGORIES JAMAIS COMMANDES
select NUMCATEGORIE
from _CATEGORIE
except ((
select NUMCATEGORIE
from _ARTICLE
where NUMARTICLE in (select NUMARTICLE
                     from _DETAILCOMMANDE) 
union 
select CAT_NUMCATEGORIE2
from _ARTICLE natural join _SE_DECOMPOSE
where NUMARTICLE in (select NUMARTICLE
                     from _DETAILCOMMANDE))
union
select CAT_NUMCATEGORIE2
from _SE_DECOMPOSE 
where  NUMCATEGORIE in (select CAT_NUMCATEGORIE2
from _ARTICLE natural join _SE_DECOMPOSE
where NUMARTICLE in (select NUMARTICLE
                     from _DETAILCOMMANDE)));  
                     
-- 3. Les clients n'ayant jamais commandé 
-- CLIENTS QUI ONT PAS COMMANDE
select NUMCLIENT
from _CLIENT
except 
select NUMCLIENT
from _COMMANDE ; 

-- 4. L'ensemble des commandes n'ayant pas été livrées totalement
-- COMMANDES PAS LIVREES EN TOTALITE
select distinct NUMCOMMANDE
from _DETAILCOMMANDE
where QUANTITECOMMANDEE <> QUANTITELIVREE AND QUANTITECOMMANDEE > QUANTITELIVREE ;
