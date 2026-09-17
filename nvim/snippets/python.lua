local cls = s({
    trig = "cls",
    name = "Class",
    dscr = "Python class"
},
{
    t("class "),
    i(1, "MyClass"),
    t({":", "    def __init__(self"}),
    i(2, ", args"),
    t({"):", "        "}),
    i(3, "pass"),
    i(0)

}
)

local func = s({
    trig = "func",
    name = "Function",
    dscr = "Python function with docstring"
},
{
    t("def "),
    i(1, "my_func"),
    t("("),
    i(2),
    t({"):", "    \""}),
    i(3, "Docstring."),
    t({"\"", "    "}),
    i(0, "pass")
}
)

local main = s({
    trig = "main",
    name = "Main guard",
    dscr = "if __name__ == '__main__' entrypoint"
},
{
    t({"def main():", "    "}),
    i(1, "pass"),
    t({"", "", "", 'if __name__ == "__main__":', "    main()"}),
    i(0)
}
)

local try = s({
    trig = "try",
    name = "Try/Except",
    dscr = "Try/except block"
},
{
    t({"try:", "    "}),
    i(1, "pass"),
    t({"", "except "}),
    i(2, "Exception"),
    t(" as "),
    i(3, "e"),
    t({":", "    "}),
    i(0, "raise")
}
)

local forr = s({
    trig = "for",
    name = "For loop",
    dscr = "For-in loop"
},
{
    t("for "),
    i(1, "item"),
    t(" in "),
    i(2, "iterable"),
    t({":", "    "}),
    i(0, "pass")
}
)

local wopen = s({
    trig = "wopen",
    name = "With open",
    dscr = "Open a file using a context manager"
},
{
    t("with open("),
    i(1, "path"),
    t(", \""),
    i(2, "r"),
    t("\") as "),
    i(3, "f"),
    t({":", "    "}),
    i(0, "data = f.read()")
}
)

local dataclass = s({
    trig = "dataclass",
    name = "Dataclass",
    dscr = "@dataclass-decorated class"
},
{
    t({"@dataclass", "class "}),
    i(1, "MyData"),
    t({":", "    "}),
    i(2, "name: str"),
    i(0)
}
)

local prop = s({
    trig = "prop",
    name = "Property",
    dscr = "@property getter"
},
{
    t({"@property", "def "}),
    i(1, "value"),
    t({"(self):", "    return self._"}),
    rep(1),
    i(0)
}
)

local log = s({
    trig = "log",
    name = "Logger setup",
    dscr = "Module-level logger boilerplate"
},
{
    t({"import logging", "", "logger = logging.getLogger(__name__)"}),
    i(0)
}
)

local test = s({
    trig = "test",
    name = "Test method",
    dscr = "unittest-style test method"
},
{
    t("def test_"),
    i(1, "something"),
    t({"(self):", "    "}),
    i(0, "pass")
}
)

local ipdb = s({
    trig = "ipdb",
    name = "Debug breakpoint",
    dscr = "Insert a breakpoint()"
},
{
    t("breakpoint()"),
    i(0)
}
)

return {
    cls,
    func,
    main,
    try,
    forr,
    wopen,
    dataclass,
    prop,
    log,
    test,
    ipdb
}
