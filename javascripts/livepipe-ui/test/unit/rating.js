module("Control.Rating");

test("Basic requirements", function () {
    expect(1);
    ok(Control.Rating, "Control.Rating");
});

test("options", function () {
    expect(1);
    var r = new Control.Rating("rating", { input: "rating-select" });
    equals(1, r.value, "a rating populated with setValueFromOption should use the contents of the option if no explicit value is set");
});
