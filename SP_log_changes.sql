CREATE PROCEDURE LogChange
    @TableName NVARCHAR(128),
    @Operation NVARCHAR(20),
    @RecordID INT,
    @UserName NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert audit log entry
        INSERT INTO AuditLogs (TableName, Operation, RecordID, UserName, ChangeDate)
        VALUES (@TableName, @Operation, @RecordID, @UserName, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Rethrow error for debugging/logging purposes
        THROW;
    END CATCH
END;
