using System;
using Application.Helpers;
using Application.Interfaces;
using Microsoft.AspNetCore.Http;
using AppContext = Application.Infrastructure.AppContext;

namespace Infrastructure.Security
{
    public class CookieService : ICookieService
    {
        public void SetCookieToken(string refreshToken)
        {
            var options = new CookieOptions
            {
                HttpOnly = true,
                Expires = DateTime.UtcNow.AddDays(7),
            };

            AppContext.Current.Response.Cookies.Append(Constants.RefreshCookieToken, refreshToken, options);
        }
    }
}