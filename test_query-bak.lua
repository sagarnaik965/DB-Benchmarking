sysbench.hooks.report_intermediate = function()
end

function thread_init()
    db_conn = sysbench.sql.driver():connect()
end

function thread_done()
    db_conn:disconnect()
end

function event()
    db_conn:query([[
        SELECT 
            u.username AS user,
            SUM(o.quantity) AS total_quantity
        FROM 
            orders o
        JOIN 
            users u ON o.user_id = u.user_id
        GROUP BY 
            u.username;
    ]])
end
