#Requires AutoHotkey v2.0+

CoordMode "Mouse", "Screen"

class AutoClicker {
   
    __New() {
        this.clickDelay := 1000 ; Default click delay in milliseconds
        this.randomOffsetRange := 0 ; Default random offset in milliseconds
        this.clickPos := [0, 0] ; Click position [x, y] (for fixed mode)
        this.isEnabled := false ; State of the auto-clicker (enabled/disabled)

        this.Gui := Gui()

        ; Title
        this.Gui.SetFont("s20 Bold")
        this.Gui.AddText("x50 y10 Center", "Triksheim AutoClicker v2")

        ; Settings Section
        this.Gui.SetFont("s12")
        this.Gui.AddText("x10 y60", "Click Delay (ms):")
        this.clickDelayField := this.Gui.AddEdit("x150 y58 w100 vClickDelay", this.clickDelay)

        this.Gui.AddText("x10 y100", "Rnd offset (ms):")
        this.randomOffsetRangeField := this.Gui.AddEdit("x150 y98 w100 vRandomOffset", this.randomOffsetRange)

        this.fixedCheckbox := this.Gui.AddCheckbox("x10 y140 vFixed", "Fixed position?")

        ; Hotkeys Section
        this.Gui.SetFont("s10 Bold")
        this.Gui.AddText("x10 y190", "Hotkeys:")

        this.Gui.SetFont("s10")
        this.Gui.AddText("x25 y220", "F12 - Toggle AutoClicker")
        this.Gui.AddText("x25 y240", "CTRL+F12 - Update Fixed Position")
        this.Gui.AddText("x25 y260", "F11 - Show GUI")
        this.Gui.AddText("x25 y280", "ESC - Hide GUI")

        this.Gui.Show()
    
        ; Bind hotkeys
        Hotkey("F12", this.Toggle.bind(this))               ; F12
        Hotkey("F11", this.ShowGui.bind(this))              ; F11
        Hotkey("^F12", this.UpdateClickPosition.bind(this)) ; CTRL+F12
        Hotkey('*Escape', (*) => this.Gui.Hide())           ; ESC
    }

    GetMousePosition() {
        xpos := 0
        ypos := 0
        MouseGetPos &xpos, &ypos
        return [xpos, ypos]
    }

    MouseLeftClickAtPos(x, y) {
        Click x, y
    }

    Toggle(obj) {
        this.isEnabled := !this.isEnabled

        if (this.isEnabled) {
            ; Stop any existing timer before enabling
            SetTimer(this.RunAutoClicker.bind(this), 0)
            
            ; Save initial fixed position if not set
            if (this.fixedCheckbox.Value && this.clickPos[1] = 0 && this.clickPos[2] = 0) {
                this.clickPos := this.GetMousePosition()
            }
            if (this.clickDelayField.Value < 10) {
                this.clickDelayField.Value := 10
            }
            if (this.randomOffsetRangeField.Value >= this.clickDelayField.Value) {
                this.randomOffsetRangeField.Value := this.clickDelayField.Value - 1
            }
            this.clickDelay := this.clickDelayField.Value
            this.randomOffsetRange := this.randomOffsetRangeField.Value
            ToolTip("AC started")
            SetTimer(() => ToolTip(""), -1000)
            this.RunAutoClicker()
        } else {
            ToolTip("AC stopped")
            SetTimer(() => ToolTip(""), -1000)
            SetTimer(this.RunAutoClicker.bind(this), 0) 
        }
    }

   

    RunAutoClicker() {
        if (!this.isEnabled) {
            return
        }

        if (this.fixedCheckbox.Value) {
            ; Save current mouse position
            currentPos := this.GetMousePosition()

            ; Click at the saved position
            this.MouseLeftClickAtPos(this.clickPos[1], this.clickPos[2])

            ; Move back to original position
            Click currentPos[1], currentPos[2], 0

        } else {
            ; Click at the current position
            Click()
        }

        if this.randomOffsetRange == 0 {
            delay := this.clickDelay

        } else {
            ; Calculate random delay
            minDelay := this.clickDelay - this.randomOffsetRange
            maxDelay := this.clickDelay + this.randomOffsetRange
            delay := Random(minDelay, maxDelay)
        }
        
        ; Schedule next click
        SetTimer(this.RunAutoClicker.bind(this), -delay)
    }

    ShowGui(obj) {
        this.Gui.Show()
    }

    UpdateClickPosition(obj) {
        this.clickPos := this.GetMousePosition()
        MsgBox "Fixed click position updated to X: " this.clickPos[1] " Y: " this.clickPos[2]
    }
}

AC := AutoClicker()