Adds JSONPath support to PostgreSQL via plpython2.

Requires the jsonpath python package:

	 pip2 install --allow-external jsonpath --allow-unverified jsonpath jsonpath

Tested on postgresql 9.3.5.


## Examples

	CREATE TABLE events (id SERIAL, data JSON);

	SELECT id FROM events WHERE jsonpath(data, '$.participants[?(@.name=="Dolphins")].name')='Dolphins';

	SELECT id FROM events WHERE 'Dolphins' = ANY (jsonpatharr(data, '$.participants[*].name'));


## Wish List:

    select id from agent_events where 'Dolphins' = ANY jsonpath(data, '$.participants[*].name');


## Other Considerations:

- [ObjectPath](https://adriank.github.io/ObjectPath/)
	- Still actively-developed, somewhat.
	- More complex than JSONPath.


## TODO

- `jsonpatharr` needs more thought and work, very raw right now.
- Test with jsonpath-rw, another JSONPath implementation.
