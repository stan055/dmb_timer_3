writeYearMonthDayUkr(List<String> s, int year, int month, int day){

        if (year == 0 || year > 4) { s[0] = "років";
        } else if (year == 1) { s[0] = "рік";
        } else s[0] = "роки";

        if (month == 0 || month > 4) { s[1] = "місяців";
        } else if (month == 1) { s[1] = "місяць";
        } else s[1] = "місяці";

        if (day == 1 || day == 31 || day == 21)  s[2] = "день";
        if (day > 1 && day < 5) s[2] = "дні";
        if (day > 21 && day < 25) s[2] = "дні";
        if (day > 4 && day < 21) s[2] = "днів";
        if (day > 24 && day < 31) s[2] = "днів";
    }

