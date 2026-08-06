package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.treasurehunt.ProgressTreasureHuntMessageComposer;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.IUserDefinedRoomEventsCtrl;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionTypeCodes;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.ListScrollParams;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.*;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.interfaces.IListPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.MenuPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.MenuItem;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FramePreset extends WiredUIPreset
   {
      private static const MENU_COPY:int = 0;
      
      private static const MENU_PASTE:int = 1;
      
      private static const MENU_COPY_INTO:int = 2;
      
      private static const MENU_CLEAR_PICKS:int = 3;
      
      private static const MENU_RESET:int = 4;
      
      private static const MENU_OPEN_CREATOR_TOOLS:int = 5;
      
      private static const MENU_SAVE:int = 6;
      
      private static const MENU_CLOSE:int = 7;
      
      protected var _frame:IFrameController;
      
      protected var _headerPreset:HeaderPreset;
      
      protected var UnknownVarFromFramePreset_IListPreset_1:IListPreset;
      
      private var UnknownVarFromFramePreset_Function_1:Function;
      
      private var _holderKey:String;
      
      private var _code:int;
      
      private var _leftRightMargin:int;
      
      private var _topBottomMargin:int;
      
      private var _ignoreEvents:Boolean;
      
      private var UnknownVarFromFramePreset_Boolean_1:Boolean;
      
      private var _scrollParams:ListScrollParams;
      
      private var UnknownVarFromFramePreset_MenuPreset_1:MenuPreset;
      
      public function FramePreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Function, param6:String, param7:int, param8:Boolean = false, param9:Boolean = false, param10:ListScrollParams = null)
      {
         super(param1,param2,param3);
         UnknownVarFromFramePreset_Function_1 = param5;
         _holderKey = param6;
         _code = param7;
         UnknownVarFromFramePreset_Boolean_1 = param9;
         _scrollParams = param10;
         _frame = param3.createFrame();
         _leftRightMargin = _frame.width - _frame.margins.right + _frame.margins.left;
         _topBottomMargin = _frame.height - _frame.margins.bottom + _frame.margins.top;
         createListView(param4);
         UnknownVarFromFramePreset_IListPreset_1.window.addEventListener("WE_RESIZED",onContentsResized);
         _frame.findChildByTag("close").addEventListener("WME_CLICK",onCloseClicked);
         _frame.content.addChild(UnknownVarFromFramePreset_IListPreset_1.window);
         _frame.color = UnknownVarFromWiredUIPreset_WiredStyle_1.frameColor;
         if(param8)
         {
            _frame.setParamFlag(65536,true);
            _frame.addEventListener("WE_RESIZED",onFrameResized);
         }
         if(_frame.menuButton != null && param9)
         {
            _frame.menuButtonVisible = true;
            _frame.menuButton.addEventListener("WME_CLICK",onMenuButtonClick);
            createMenuPreset();
         }
      }
      
      protected function createListView(param1:Array) : void
      {
         var _loc16_:SpacerPreset = null;
         var _loc8_:int = 0;
         var _loc17_:WiredUIPreset = null;
         var _loc2_:int = 0;
         var _loc13_:SpacerPreset = null;
         var _loc4_:SpacerPreset = null;
         var _loc11_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:ListScrollParams = null;
         var _loc15_:IListPreset = null;
         var _loc6_:Array = null;
         var _loc12_:int = UnknownVarFromWiredUIPreset_WiredStyle_1.sectionSpacing;
         var _loc10_:Array = [];
         var _loc9_:HeaderPreset = null;
         var _loc14_:FooterPreset = null;
         var _loc7_:* = param1;
         if(_scrollParams != null && _scrollParams.stickyHeader && _loc7_.length > 0 && _loc7_[0] is HeaderPreset)
         {
            _loc9_ = param1[0] as HeaderPreset;
            _loc7_ = param1.slice(1,_loc7_.length);
         }
         if(_scrollParams != null && _scrollParams.stickyFooter && _loc7_.length > 0 && _loc7_[_loc7_.length - 1] is FooterPreset)
         {
            _loc14_ = _loc7_[_loc7_.length - 1] as FooterPreset;
            _loc7_ = _loc7_.slice(0,_loc7_.length - 1);
         }
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc17_ = _loc7_[_loc8_];
            if(_loc17_ is HeaderPreset)
            {
               _headerPreset = _loc17_ as HeaderPreset;
            }
            _loc10_.push(_loc17_);
            if(_loc8_ < _loc7_.length - 1)
            {
               _loc16_ = UnknownVarFromWiredUIPreset_PresetManager_1.createSpacer(_loc12_);
               _loc17_.blendSpacer = _loc16_;
               _loc10_.push(_loc16_);
            }
            _loc8_++;
         }
         if(_scrollParams != null)
         {
            if(_loc9_ != null || _loc14_ != null)
            {
               _loc2_ = 0;
               if(_loc9_ != null)
               {
                  _loc2_ += _loc9_.window.height + _loc12_;
                  _loc13_ = UnknownVarFromWiredUIPreset_PresetManager_1.createSpacer(_loc12_);
                  _loc10_.unshift(_loc13_);
               }
               if(_loc14_ != null)
               {
                  _loc2_ += _loc14_.window.height + _loc12_;
                  _loc4_ = UnknownVarFromWiredUIPreset_PresetManager_1.createSpacer(_loc12_);
                  _loc10_.push(_loc4_);
               }
               _loc11_ = Math.max(0,_scrollParams.minHeight - _loc2_);
               _loc3_ = Math.max(_loc11_,_scrollParams.maxHeight - _loc2_);
               _loc5_ = new ListScrollParams(_scrollParams.alwaysShowScrollbar,_loc11_,_loc3_,false,false);
               _loc15_ = UnknownVarFromWiredUIPreset_PresetManager_1.createScrollList(_loc10_,_loc5_);
               _loc15_.spacing = 0;
               _loc6_ = [];
               if(_loc9_ != null)
               {
                  _loc6_.push(_loc9_);
               }
               _loc6_.push(_loc15_);
               if(_loc14_ != null)
               {
                  _loc6_.push(_loc14_);
               }
               UnknownVarFromFramePreset_IListPreset_1 = UnknownVarFromWiredUIPreset_PresetManager_1.createSimpleListView(true,_loc6_);
               UnknownVarFromFramePreset_IListPreset_1.spacing = 0;
               return;
            }
            UnknownVarFromFramePreset_IListPreset_1 = UnknownVarFromWiredUIPreset_PresetManager_1.createScrollList(_loc10_,_scrollParams);
         }
         else
         {
            UnknownVarFromFramePreset_IListPreset_1 = UnknownVarFromWiredUIPreset_PresetManager_1.createSimpleListView(true,_loc10_);
         }
         UnknownVarFromFramePreset_IListPreset_1.spacing = 0;
      }
      
      public function set title(param1:String) : void
      {
         _frame.caption = param1;
      }
      
      private function onMenuButtonClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromFramePreset_MenuPreset_1)
         {
            UnknownVarFromFramePreset_MenuPreset_1.requestOpen();
         }
      }
      
      public function refreshForNewTriggerable() : void
      {
         if(UnknownVarFromFramePreset_MenuPreset_1)
         {
            UnknownVarFromFramePreset_MenuPreset_1.setSelected(2,false);
            updateButtonDisabledStates();
         }
      }
      
      public function updateButtonDisabledStates() : void
      {
         var _loc1_:IUserDefinedRoomEventsCtrl = null;
         var _loc2_:Boolean = false;
         if(UnknownVarFromFramePreset_MenuPreset_1)
         {
            _loc1_ = _roomEvents.wiredCtrl;
            _loc2_ = _roomEvents.wiredMenu.hasWritePermission;
            UnknownVarFromFramePreset_MenuPreset_1.setDisabled(0,!_loc2_);
            UnknownVarFromFramePreset_MenuPreset_1.setDisabled(1,!_loc2_ || !_loc1_.hasCurrentElementInClipboard());
            UnknownVarFromFramePreset_MenuPreset_1.setDisabled(2,!_loc2_);
            UnknownVarFromFramePreset_MenuPreset_1.setDisabled(3,!_loc2_ || _loc1_.getStuffIds().length + _loc1_.getStuffIds2().length == 0);
            UnknownVarFromFramePreset_MenuPreset_1.setDisabled(4,!_loc2_);
            UnknownVarFromFramePreset_MenuPreset_1.setDisabled(5,false);
            UnknownVarFromFramePreset_MenuPreset_1.setDisabled(6,!_loc2_);
            UnknownVarFromFramePreset_MenuPreset_1.setDisabled(7,false);
         }
      }
      
      private function createMenuPreset() : void
      {
         var _loc1_:Array = [new MenuItem("${wiredfurni.params.menu.copy}",onCopyConfigMenuClick,"${wiredfurni.params.menu.copy_paste.tooltip}"),new MenuItem("${wiredfurni.params.menu.paste}",onPasteConfigMenuClick,"${wiredfurni.params.menu.copy_paste.tooltip}"),new MenuItem("${wiredfurni.params.menu.paste_into}",null,"${wiredfurni.params.menu.paste_into.tooltip}",true),MenuPreset.SPACER,new MenuItem("${wiredfurni.params.menu.clear_picks}",onClearPicksMenuClick),new MenuItem("${wiredfurni.params.menu.reset}",onResetMenuClick),MenuPreset.SPACER,new MenuItem("${wiredfurni.params.menu.open_menu}",onOpenMenuMenuClick),MenuPreset.SPACER,new MenuItem("${wiredfurni.params.menu.save}",onSaveMenuClick,"${wiredfurni.params.menu.save.tooltip}"),new MenuItem("${wiredfurni.params.menu.close}",onCloseMenuClick)];
         if(_holderKey == "action" && _code == ActionTypeCodes.RESET)
         {
            _loc1_.push(MenuPreset.SPACER);
            _loc1_.push(new MenuItem("Erase from existence",onEraseClick));
         }
         UnknownVarFromFramePreset_MenuPreset_1 = UnknownVarFromWiredUIPreset_PresetManager_1.createMenuPreset(_loc1_,_frame.menuButton);
      }
      
      private function onFrameResized(param1:WindowEvent) : void
      {
         if(!_ignoreEvents)
         {
            resizeToWidth(_frame.width);
         }
      }
      
      private function onContentsResized(param1:WindowEvent) : void
      {
         if(!_ignoreEvents)
         {
            fixHeight();
         }
      }
      
      private function onCloseClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromFramePreset_Function_1 != null)
         {
            UnknownVarFromFramePreset_Function_1();
         }
      }
      
      public function get isCopyingIntoMode() : Boolean
      {
         return UnknownVarFromFramePreset_MenuPreset_1 != null && UnknownVarFromFramePreset_MenuPreset_1.getSelected(2);
      }
      
      override public function get window() : IWindowModel
      {
         return _frame;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _ignoreEvents = true;
         _frame.width = param1;
         UnknownVarFromFramePreset_IListPreset_1.resizeToWidth(param1 - _leftRightMargin);
         _ignoreEvents = false;
         fixHeight();
      }
      
      private function get headerFrameBackground() : IWindowModel
      {
         return _frame.findChildByTag("wired_header_bg");
      }
      
      private function fixHeight() : void
      {
         _ignoreEvents = true;
         var _loc2_:int = UnknownVarFromFramePreset_IListPreset_1.window.height + _topBottomMargin;
         _frame.limits.minHeight = _loc2_;
         _frame.limits.maxHeight = _loc2_;
         _frame.height = _loc2_;
         _ignoreEvents = false;
         var _loc1_:IWindowModel = headerFrameBackground;
         if(_loc1_ != null && _headerPreset != null)
         {
            _loc1_.height = _headerPreset.window.height + _frame.margins.top + UnknownVarFromWiredUIPreset_WiredStyle_1.sectionSpacing;
         }
      }
      
      override protected function get childPresets() : Array
      {
         if(UnknownVarFromFramePreset_MenuPreset_1 == null)
         {
            return [UnknownVarFromFramePreset_IListPreset_1];
         }
         return [UnknownVarFromFramePreset_IListPreset_1,UnknownVarFromFramePreset_MenuPreset_1];
      }
      
      override public function dispose() : void
      {
         UnknownVarFromFramePreset_IListPreset_1.window.removeEventListener("WE_RESIZED",onContentsResized);
         _frame.removeEventListener("WE_RESIZED",onFrameResized);
         if(disposed)
         {
            return;
         }
         super.dispose();
         _frame.dispose();
         _frame = null;
         UnknownVarFromFramePreset_IListPreset_1 = null;
         UnknownVarFromFramePreset_Function_1 = null;
         UnknownVarFromFramePreset_MenuPreset_1 = null;
      }
      
      public function onCopyConfigMenuClick() : void
      {
         _roomEvents.wiredCtrl.createClipboardCopy();
      }
      
      public function onPasteConfigMenuClick() : void
      {
         _roomEvents.wiredCtrl.pasteFromClipboard();
      }
      
      public function onClearPicksMenuClick() : void
      {
         _roomEvents.wiredCtrl.clearStuffPicks();
      }
      
      public function onResetMenuClick() : void
      {
         _roomEvents.wiredCtrl.resetToDefault();
      }
      
      public function onOpenMenuMenuClick() : void
      {
         _roomEvents.context.createLinkEvent("wiredmenu/open");
      }
      
      public function onSaveMenuClick() : void
      {
         _roomEvents.wiredCtrl.update(1);
      }
      
      public function onCloseMenuClick() : void
      {
         _roomEvents.wiredCtrl.close();
      }
      
      public function onEraseClick() : void
      {
         _roomEvents.send(new ProgressTreasureHuntMessageComposer("wf15",_holderKey + _code));
         _roomEvents.wiredCtrl.close();
      }
   }
}

