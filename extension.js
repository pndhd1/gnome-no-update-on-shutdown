import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as EndSessionDialog from 'resource:///org/gnome/shell/ui/endSessionDialog.js';

const dialogPrototype = EndSessionDialog.EndSessionDialog.prototype;

export default class NoUpdateOnShutdownExtension extends Extension {
    enable() {
        this._originalGetUpdateState = dialogPrototype._getUpdateState;

        // The end session dialog derives everything about pending updates from
        // this single state value: reporting "unknown" keeps the checkbox
        // hidden and unchecked, and stops the dialog from switching to its
        // "Restart & Install Updates" variant. Nothing else is touched, so no
        // update is ever triggered or cancelled by the dialog.
        dialogPrototype._getUpdateState = async function () {
            return 'unknown';
        };
    }

    disable() {
        dialogPrototype._getUpdateState = this._originalGetUpdateState;
        this._originalGetUpdateState = null;
    }
}
