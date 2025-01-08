({
    applyColor: function (component, event) {
        // Get the color value from the event
        const colorVal = event.getParam('colorVal');
        component.set('v.colorCodeText', colorVal);
    }
})
