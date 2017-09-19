function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'xtimulus', 'pipeline_stimulus');
end
obj = schemaObject;
end
