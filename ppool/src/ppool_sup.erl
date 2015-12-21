-module(ppool_sup).
-export([start_link/3, init/1]).
-behaviour(supervisor).

start_link(Name, Limit, MFA) ->
    supervisor:start_link(?MODULE, {Name, Limit, MFA}).

init({Name, Limit, MFA}) ->
    {ok, {{one_for_all, 1, 3600},
          [{serv,
             {ppool_serv, start_link, [Name, Limit, self(), MFA]},
             permanent,
             5000, 
             worker,
             [ppool_serv]}]}}.