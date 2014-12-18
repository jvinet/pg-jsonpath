CREATE OR REPLACE FUNCTION jsonPath(jsonstr json, path text) RETURNS text AS
$$
    import re
    import json
    from jsonpath import jsonpath as _jsonpath

    jsonobj = json.loads(jsonstr)

    # TODO: catch parse failures
    result = _jsonpath(jsonobj, path, 'VALUE', 0, True)

    if len(result) == 1:
        pg_result = json.dumps(result[0])
        # Strip outer quotes
        pg_result = re.sub(r'^"(.*)"$', r'\1', pg_result)
    else:
        pg_result = json.dumps([r for r in result])

    return pg_result.decode('utf-8')
$$
LANGUAGE plpythonu IMMUTABLE;

CREATE OR REPLACE FUNCTION jsonPathArr(jsonstr json, path text) RETURNS text[] AS
$$
    import re
    import json
    from jsonpath import jsonpath as _jsonpath

    jsonobj = json.loads(jsonstr)
    result = _jsonpath(jsonobj, path, 'VALUE', 0, True)

    if not result:
        return list()

    pg_result = result

    return pg_result
$$
LANGUAGE plpythonu IMMUTABLE;

-- vim: set ft=python:
