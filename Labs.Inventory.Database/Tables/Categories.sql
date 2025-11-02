CREATE TABLE [dbo].[Categories] (
    [CategoryId] INT IDENTITY(1,1) PRIMARY KEY,
    [CategoryName] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    [ParentCategoryId] INT NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    CONSTRAINT [FK_Categories_ParentCategory]
    FOREIGN KEY ([ParentCategoryId])
    REFERENCES [dbo].[Categories]([CategoryId])
    );

CREATE UNIQUE INDEX [IX_Categories_CategoryName]
    ON [dbo].[Categories]([CategoryName])
    WHERE [IsActive] = 1;