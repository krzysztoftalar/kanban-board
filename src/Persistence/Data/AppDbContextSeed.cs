using System.Collections.Generic;
using System.Threading.Tasks;
using Domain.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Persistence.Data
{
    public static class AppDbContextSeed
    {
        public static async Task SeedData(AppDbContext context, UserManager<AppUser> userManager)
        {
            var isEmptyDatabse = await context.Users.AnyAsync();

            if (!isEmptyDatabse)
            {
                foreach (var user in GetPreconfiguredUsers())
                {
                    await userManager.CreateAsync(user, "Pa$$w0rd");
                }
                await context.SaveChangesAsync();
                
                // await context.Boards.AddRangeAsync(GetPreconfiguredBoards());
                // await context.BoardTemplates.AddRangeAsync(GetBoardTemplates());
                await context.SaveChangesAsync();
            }
        }
        
        
        private static IEnumerable<AppUser> GetPreconfiguredUsers()
        {
            return new List<AppUser>
            {
                new AppUser
                {
                    Id = "a",
                    UserName = "bob",
                    Email = "bob@test.com",
                    EmailConfirmed = true,
                },
                new AppUser
                {
                    Id = "b",
                    UserName = "agata",
                    Email = "agata@test.com",
                    EmailConfirmed = true,
                },
                new AppUser
                {
                    Id = "c",
                    UserName = "tom",
                    Email = "tom@test.com",
                    EmailConfirmed = true,
                },
                new AppUser
                {
                    Id = "d",
                    UserName = "jack",
                    Email = "jack@test.com",
                    EmailConfirmed = true,
                },
            };
        }

        private static IEnumerable<BoardTemplate> GetBoardTemplates()
        {
            return new List<BoardTemplate>
            {
                new BoardTemplate
                {
                    Title = "Starter Kanban",
                    ColumnTemplates = new List<ColumnTemplate>
                    {
                        new ColumnTemplate
                        {
                            Title = "To Do"
                        },
                        new ColumnTemplate
                        {
                            Title = "In Progress"
                        },
                        new ColumnTemplate
                        {
                            Title = "Done"
                        },
                    }
                },
                new BoardTemplate
                {
                    Title = "Weekly Tasks",
                    ColumnTemplates = new List<ColumnTemplate>
                    {
                        new ColumnTemplate
                        {
                            Title = "Monday"
                        },
                        new ColumnTemplate
                        {
                            Title = "Tuesday"
                        },
                        new ColumnTemplate
                        {
                            Title = "Wednesday"
                        },
                        new ColumnTemplate
                        {
                            Title = "Thursday"
                        },
                        new ColumnTemplate
                        {
                            Title = "Friday"
                        },
                        new ColumnTemplate
                        {
                            Title = "Saturday"
                        },
                        new ColumnTemplate
                        {
                            Title = "Sunday"
                        },
                    }
                },
                new BoardTemplate
                {
                    Title = "Sprint/Release Cycle",
                    ColumnTemplates = new List<ColumnTemplate>
                    {
                        new ColumnTemplate
                        {
                            Title = "Backlog"
                        },
                        new ColumnTemplate
                        {
                            Title = "In Progress"
                        },
                        new ColumnTemplate
                        {
                            Title = "Testing"
                        },
                        new ColumnTemplate
                        {
                            Title = "Done"
                        },
                    }
                },
                new BoardTemplate
                {
                    Title = "Product Roadmap",
                    ColumnTemplates = new List<ColumnTemplate>
                    {
                        new ColumnTemplate
                        {
                            Title = "Q1"
                        },
                        new ColumnTemplate
                        {
                            Title = "Q2"
                        },
                        new ColumnTemplate
                        {
                            Title = "Q3"
                        },
                        new ColumnTemplate
                        {
                            Title = "Q4"
                        },
                    }
                },
                new BoardTemplate
                {
                    Title = "Product Backlog",
                    ColumnTemplates = new List<ColumnTemplate>
                    {
                        new ColumnTemplate
                        {
                            Title = "Bugs"
                        },
                        new ColumnTemplate
                        {
                            Title = "Features"
                        },
                        new ColumnTemplate
                        {
                            Title = "Next Release"
                        },
                    }
                },
            };
        }

        private static IEnumerable<Board> GetPreconfiguredBoards()
        {
            return new List<Board>
            {
                new Board
                {
                    Title = "Trillo Shop",
                    BoardTemplateId = 1,
                    Columns = new List<Column>
                    {
                        new Column
                        {
                            Title = "To Do",
                            Index = 0,
                            Cards = new List<Card>
                            {
                                new Card
                                {
                                    Title = "Create a form for orders",
                                    Index = 0,
                                },
                                new Card
                                {
                                    Title = "Add registrations",
                                    Index = 1,
                                },
                                new Card
                                {
                                    Title = "Add login",
                                    Index = 2,
                                }
                            }
                        },
                        new Column
                        {
                            Title = "In Progress",
                            Index = 1,
                            Cards = new List<Card>
                            {
                                new Card
                                {
                                    Title = "Displaying products",
                                    Index = 0,
                                },
                                new Card
                                {
                                    Title = "Displaying the cart",
                                    Index = 1,
                                }
                            }
                        },
                        new Column
                        {
                            Title = "Done",
                            Index = 2,
                            Cards = new List<Card>
                            {
                                new Card
                                {
                                    Title = "Add a loading screen",
                                    Index = 0,
                                },
                                new Card
                                {
                                    Title = "Add product filtering",
                                    Index = 1,
                                }
                            }
                        }
                    }
                }
            };
        }
    }
}