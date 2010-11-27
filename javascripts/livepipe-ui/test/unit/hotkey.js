module("HotKey");

test("Basic requirements", function () {
    expect(1);
    ok(HotKey, "HotKey");
});

test("destroy", function () {
    var a = new HotKey("a");
    equals(1, HotKey.hotkeys.length, 
        "Hotkeys length is 1 after new one is created");
    a.destroy();
    equals(0, HotKey.hotkeys.length,
        "Hotkeys length is 0 after the last one is destroyed");
});
