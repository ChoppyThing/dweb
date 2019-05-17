module database.database;

import hunt.database;

class DatabaseConnection
{
    string connection;
    int perPage = 5;

    this()
    {
        this.connection = "mysql://root:test@localhost:3306/train?charset=utf8mb4";
    }
}
