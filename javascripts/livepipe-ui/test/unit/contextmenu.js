module("Control.ContextMenu");

test("Basic requirements", function () {
    expect(1);
    ok(Control.ContextMenu, "Control.ContextMenu");
});

test("add items", function () {
    expect(1);
    var c = new Control.ContextMenu("contextmenu");
    c.addItem({ label : "Test" });
    ok(c.items[0].enabled, "items added with addItem are enabled by default");
}); 
