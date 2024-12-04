local report_interval = 5 -- Set the interval for intermediate reports
local last_report_time = os.time()
local test_start_time = os.time() -- Capture the start time of the test
local query_count = 0 -- Track the number of queries performed

function thread_init()
   -- Initialize thread-level variables or connections here
end

function thread_done()
   -- Clean up resources
end

function event()
   -- Perform your query
   db_query("SELECT u.username AS user, SUM(o.quantity) AS total_quantity FROM orders o JOIN users u ON o.user_id = u.user_id GROUP BY u.username;")
   query_count = query_count + 1

   -- Check if it's time to report
   local now = os.time()
   if now - last_report_time >= report_interval then
       last_report_time = now
       local elapsed_time = now - test_start_time
       print(string.format("[ %ds ] queries performed: %d", elapsed_time, query_count))
   end
end
