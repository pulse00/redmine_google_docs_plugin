module("Control.Window");

test("Basic requirements", function () {
    expect(1);
    ok(Control.Window, "Control.Window");
});

test("draggable", function () {
    expect(3);
    ok(Draggables, "Draggables");

    var w = new Control.Window("window", { draggable : true });

    equals(Draggables.observers.length, 1, "1 draggable observer is present after initialization");
    w.destroy();
    equals(Draggables.observers.length, 0, "0 draggable observers are present after the last one is destroyed");
}); 
