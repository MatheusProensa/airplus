package com.sulake.habbo.toolbar.extensions.settings
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.customfilter.AddToCustomFilterMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.customfilter.GetCustomFilterMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.customfilter.RemoveFromCustomFilterMessageComposer;
   import com.sulake.habbo.communication.messages.parser.customfilter.GetCustomFilterResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.customfilter.GetCustomFilterResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.customfilter.ModifyCustomFilterResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.customfilter.ModifyCustomFilterResultMessageEventParser;
   import com.sulake.habbo.toolbar.HabboToolbar;
   
   public class WordFilterSettingsView implements IComponentInterfaceQueue
   {
      private var _toolbar:HabboToolbar;
      
      private var UnknownVarFromWordFilterSettingsView_Int_1:int = -1;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromWordFilterSettingsView_Array_1:Array;
      
      private var UnknownVarFromWordFilterSettingsView_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromWordFilterSettingsView_ITextFieldWindow_1:ITextFieldWindow;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function WordFilterSettingsView(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         UnknownVarFromWordFilterSettingsView_Array_1 = [];
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new ModifyCustomFilterResultMessageEvent(onModifyCustomFilter));
         addMessageEvent(new GetCustomFilterResultMessageEvent(onCustomWords));
         prepareWindow();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         var _loc1_:XmlAsset = _toolbar.assets.getAssetByName("custom_word_filter_settings_xml") as XmlAsset;
         _window = _toolbar.windowManager.buildFromXML(_loc1_.content as XML) as IWindowController_1;
         _window.findChildByName("remove_btn").addEventListener("WME_CLICK",onRemoveWordClick);
         _window.findChildByName("add_btn").addEventListener("WME_CLICK",onAddWordClick);
         _window.findChildByName("back_btn").addEventListener("WME_CLICK",onCloseButtonClick);
         UnknownVarFromWordFilterSettingsView_ITextFieldWindow_1 = _window.findChildByName("add_word_input") as ITextFieldWindow;
         UnknownVarFromWordFilterSettingsView_IItemListWindow_1 = IItemListWindow(_window.findChildByName("wordlist"));
         _toolbar.connection.send(new GetCustomFilterMessageComposer());
      }
      
      private function onModifyCustomFilter(param1:ModifyCustomFilterResultMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ModifyCustomFilterResultMessageEventParser = param1.getParser();
         if(_loc2_.result == 1)
         {
            if(UnknownVarFromWordFilterSettingsView_Array_1.indexOf(_loc2_.word) == -1)
            {
               UnknownVarFromWordFilterSettingsView_Array_1.push(_loc2_.word);
            }
         }
         else if(_loc2_.result == 3)
         {
            _loc3_ = int(UnknownVarFromWordFilterSettingsView_Array_1.indexOf(_loc2_.word));
            if(_loc3_ != -1)
            {
               UnknownVarFromWordFilterSettingsView_Array_1.splice(_loc3_,1);
            }
         }
         refreshBadWords();
      }
      
      private function onCustomWords(param1:GetCustomFilterResultMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GetCustomFilterResultMessageEventParser = param1.getParser();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.words.length)
         {
            if(UnknownVarFromWordFilterSettingsView_Array_1.indexOf(_loc2_.words[_loc3_]) == -1)
            {
               UnknownVarFromWordFilterSettingsView_Array_1.push(_loc2_.words[_loc3_]);
            }
            _loc3_++;
         }
         if(UnknownVarFromWordFilterSettingsView_IItemListWindow_1)
         {
            UnknownVarFromWordFilterSettingsView_IItemListWindow_1.removeListItems();
            refreshBadWords();
         }
      }
      
      private function refreshBadWords() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IWindowController_1 = null;
         UnknownVarFromWordFilterSettingsView_IItemListWindow_1.autoArrangeItems = false;
         _loc2_ = 0;
         while(true)
         {
            _loc1_ = IWindowController_1(UnknownVarFromWordFilterSettingsView_IItemListWindow_1.getListItemAt(_loc2_));
            if(_loc1_ == null)
            {
               if(UnknownVarFromWordFilterSettingsView_Array_1[_loc2_] == null)
               {
                  break;
               }
               _loc1_ = getListEntry(_loc2_);
               UnknownVarFromWordFilterSettingsView_IItemListWindow_1.addListItem(_loc1_);
            }
            if(UnknownVarFromWordFilterSettingsView_Array_1[_loc2_] != null)
            {
               _loc1_.color = this.getBgColor(_loc2_,false);
               refreshEntryDetails(_loc1_,UnknownVarFromWordFilterSettingsView_Array_1[_loc2_]);
               _loc1_.visible = true;
               _loc1_.height = 20;
            }
            else
            {
               _loc1_.height = 0;
               _loc1_.visible = false;
            }
            _loc2_++;
         }
         UnknownVarFromWordFilterSettingsView_IItemListWindow_1.autoArrangeItems = true;
         UnknownVarFromWordFilterSettingsView_IItemListWindow_1.invalidate();
      }
      
      private function refreshEntryDetails(param1:IWindowController_1, param2:String) : void
      {
         param1.findChildByName("text").caption = param2;
      }
      
      private function onCloseButtonClick(param1:WindowEvent) : void
      {
         disposeWindow();
      }
      
      private function onAddWordClick(param1:WindowMouseEvent) : void
      {
         if(!UnknownVarFromWordFilterSettingsView_ITextFieldWindow_1)
         {
            return;
         }
         var _loc2_:String = UnknownVarFromWordFilterSettingsView_ITextFieldWindow_1.text;
         if(_loc2_ && _loc2_.length > 0 && UnknownVarFromWordFilterSettingsView_Array_1.indexOf(_loc2_) == -1)
         {
            _toolbar.connection.send(new AddToCustomFilterMessageComposer(_loc2_));
            UnknownVarFromWordFilterSettingsView_ITextFieldWindow_1.text = "";
            UnknownVarFromWordFilterSettingsView_Int_1 = -1;
         }
      }
      
      private function onRemoveWordClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWordFilterSettingsView_Int_1 < 0)
         {
            return;
         }
         var _loc2_:IWindowController_1 = IWindowController_1(UnknownVarFromWordFilterSettingsView_IItemListWindow_1.getListItemAt(UnknownVarFromWordFilterSettingsView_Int_1));
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:String = _loc2_.findChildByName("text").caption;
         UnknownVarFromWordFilterSettingsView_Int_1 = -1;
         _toolbar.connection.send(new RemoveFromCustomFilterMessageComposer(_loc3_));
      }
      
      private function refreshColorsAfterClick(param1:IItemListWindow) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindowController_1 = null;
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromWordFilterSettingsView_Array_1.length)
         {
            _loc2_ = IWindowController_1(param1.getListItemAt(_loc3_));
            _loc2_.color = getBgColor(_loc3_,false);
            _loc3_++;
         }
      }
      
      private function getListEntry(param1:int) : IWindowController_1
      {
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("custom_word_filter_item_xml") as XmlAsset;
         var _loc2_:IWindowController_1 = _toolbar.windowManager.buildFromXML(_loc3_.content as XML) as IWindowController_1;
         if(!_loc2_)
         {
            return null;
         }
         var _loc4_:IRegionWindow = IRegionWindow(_loc2_.findChildByName("bg_region"));
         _loc4_.addEventListener("WME_CLICK",onBgMouseClick);
         _loc4_.addEventListener("WME_OVER",onBgMouseOver);
         _loc4_.addEventListener("WME_OUT",onBgMouseOut);
         _loc2_.id = param1;
         return _loc2_;
      }
      
      protected function getBgColor(param1:int, param2:Boolean) : uint
      {
         if(param1 == UnknownVarFromWordFilterSettingsView_Int_1)
         {
            return 4288329945;
         }
         return param2 ? 4290173439 : (param1 % 2 != 0 ? 4294967295 : 4293519841);
      }
      
      private function onBgMouseClick(param1:WindowEvent) : void
      {
         UnknownVarFromWordFilterSettingsView_Int_1 = param1.target.parent.id;
         refreshColorsAfterClick(param1.target.findParentByName("wordlist") as IItemListWindow);
      }
      
      private function onBgMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:IWindowController_1 = IWindowController_1(param1.target.parent);
         _loc2_.color = getBgColor(-1,true);
      }
      
      private function onBgMouseOut(param1:WindowEvent) : void
      {
         var _loc2_:IWindowController_1 = IWindowController_1(param1.target.parent);
         _loc2_.color = getBgColor(_loc2_.id,false);
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_toolbar.communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      private function removeMessageEvents() : void
      {
         if(!_toolbar.communicationManager || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function disposeWindow() : void
      {
         removeMessageEvents();
         if(_window)
         {
            _window.findChildByName("remove_btn").removeEventListener("WME_CLICK",onRemoveWordClick);
            _window.findChildByName("add_btn").removeEventListener("WME_CLICK",onAddWordClick);
            _window.findChildByName("back_btn").removeEventListener("WME_CLICK",onCloseButtonClick);
            _window.visible = false;
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromWordFilterSettingsView_IItemListWindow_1)
         {
            UnknownVarFromWordFilterSettingsView_IItemListWindow_1.dispose();
            UnknownVarFromWordFilterSettingsView_IItemListWindow_1 = null;
         }
         if(UnknownVarFromWordFilterSettingsView_ITextFieldWindow_1)
         {
            UnknownVarFromWordFilterSettingsView_ITextFieldWindow_1.dispose();
            UnknownVarFromWordFilterSettingsView_ITextFieldWindow_1 = null;
         }
         if(UnknownVarFromWordFilterSettingsView_Array_1)
         {
            UnknownVarFromWordFilterSettingsView_Array_1.length = 0;
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         disposeWindow();
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
   }
}

