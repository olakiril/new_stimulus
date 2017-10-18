function run_protocol(protocol_filename)

try
    run(protocol_filename)
catch ME
    disp(ME.identifier)
end