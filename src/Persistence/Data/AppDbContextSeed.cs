using System.Collections.Generic;
using System.Threading.Tasks;
using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Persistence.Data
{
    public static class AppDbContextSeed
    {
        public static async Task SeedData(AppDbContext context)
        {
            var isEmptyDatabse = await context.Boards.AnyAsync();

            if (!isEmptyDatabse)
            {
                await context.Boards.AddRangeAsync(GetPreconfiguredBoards());
                await context.SaveChangesAsync();
            }
        }

        private static IEnumerable<Board> GetPreconfiguredBoards()
        {
            return new List<Board>
            {
                new Board
                {
                    Title = "Trillo Shop",
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