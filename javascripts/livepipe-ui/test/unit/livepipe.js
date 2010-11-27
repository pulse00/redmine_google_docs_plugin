module("LivePipe base");

test("Basic requirements", function () {
    expect(7);
    ok(Prototype, "Prototype");
    ok(Control, "Control");
    ok($proc, "$proc");
    ok($value, "$value");
    ok(Object.Event, "Object.Event");
    ok($$("*").first().observeOnce, "Element#observeOnce");
    ok(IframeShim, "IframeShim");
});

test("mouse:wheel", function () {
    expect(1);
    document.observe("mouse:wheel", function (evt) { 
        ok(true, "mouse:wheel fires"); 
    });
    document.fire("mouse:wheel", { delta : 1 });
});
