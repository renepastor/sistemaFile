/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/
begin;
DROP role protegido;
commit;

begin;
create role protegido login password '2021';
commit;

begin;
grant usage on schema base to protegido;
commit;

begin;
grant execute on function base.auth(text, text) to protegido;

commit;


