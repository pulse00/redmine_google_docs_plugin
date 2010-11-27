module("Control.SelectMultiple");

test("Basic requirements", function () {
    expect(1);
    ok(Control.SelectMultiple, "Control.SelectMultiple");
});

// FIXME: afterChange does not fire when click is called on the checkbox
/*
test("afterChange", function () {
    expect(1);
    var first = true, // Skip the event on load
        s = new Control.SelectMultiple("selectmultiple", "selectmultiple-boxes",
                {
                    afterChange : function (v) {
                        if (!first) { 
                            equals("", v, "after change passes an empty string when no items are selected");
                        }
                        first = false;
                    }
                }
        );
    s.checkboxes[0].click();
}); 
*/
