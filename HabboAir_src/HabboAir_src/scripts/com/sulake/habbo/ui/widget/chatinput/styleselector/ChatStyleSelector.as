package com.sulake.habbo.ui.widget.chatinput.styleselector
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.freeflowchat.style.UnknownIHabboFreeflowchatStyle1;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputView;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class ChatStyleSelector implements IComponentInterfaceQueue
   {
      private static const GRID_SPACING:int = 1;
      
      public static const MAX_GRID_COLUMNS:int = 6;
      
      public static const UnknownConstFromChatStyleSelector_Int_1:int = 4;
      
      private static const FONT_SIZE_SMALL:int = 0;
      
      private static const FONT_SIZE_MEDIUM:int = 1;
      
      private static const FONT_SIZE_LARGE:int = 2;
      
      private static const FONT_SIZE_XL:int = 3;
      
      private static const FONT_SIZE_XXL:int = 4;
      
      private static var _selected:ChatStyleGridEntry = null;
      
      private static var _styleRequiresUpdate:Boolean = false;
      
      private static var UnknownVarFromChatStyleSelector_Int_1:int = 0;
      
      private static const FONT_SIZE_LABELS:Array = ["S","M","L","XL","XXL"];
      
      private var _chatInputView:RoomChatInputView;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromChatStyleSelector_ChatStyleGridView_1:ChatStyleGridView;
      
      private var _entries:Vector.<ChatStyleGridEntry> = new Vector.<ChatStyleGridEntry>();
      
      private var UnknownVarFromChatStyleSelector_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromChatStyleSelector_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromChatStyleSelector_Shape_1:Shape;
      
      public function ChatStyleSelector(param1:RoomChatInputView, param2:IWindowController_1, param3:ISessionDataManager)
      {
         super();
         _chatInputView = param1;
         UnknownVarFromChatStyleSelector_ChatStyleGridView_1 = new ChatStyleGridView(_chatInputView);
         UnknownVarFromChatStyleSelector_IWindowModel_1 = buildTemplateWindow("chatinput_chatstyle_template_xml");
         UnknownVarFromChatStyleSelector_IWindowModel_2 = buildTemplateWindow("chatinput_chatfontsize_template_xml");
         _container = param2;
         if(_container != null)
         {
            _container.procedure = windowProc;
         }
         if(UnknownVarFromChatStyleSelector_ChatStyleGridView_1 != null && UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window != null && _chatInputView.chatStyleMenuContainer != null)
         {
            _chatInputView.chatStyleMenuContainer.addChild(UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window);
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window.x = 0;
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window.y = 0;
         }
         _chatInputView.chatStyleMenuContainer.visible = false;
         createFontSizeOptions();
      }
      
      private static function isWindowInTree(param1:IWindowModel, param2:IWindowModel) : Boolean
      {
         while(param1 != null)
         {
            if(param1 == param2)
            {
               return true;
            }
            param1 = param1.parent;
         }
         return false;
      }
      
      public function dispose() : void
      {
         while(_entries.length > 1)
         {
            _entries.pop();
         }
         _entries = null;
         if(_container != null)
         {
            _container.procedure = null;
         }
         if(UnknownVarFromChatStyleSelector_ChatStyleGridView_1 != null)
         {
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.dispose();
         }
         UnknownVarFromChatStyleSelector_ChatStyleGridView_1 = null;
         _container = null;
         UnknownVarFromChatStyleSelector_IWindowModel_2 = null;
         if(UnknownVarFromChatStyleSelector_Shape_1 && UnknownVarFromChatStyleSelector_Shape_1.parent)
         {
            UnknownVarFromChatStyleSelector_Shape_1.parent.removeChild(UnknownVarFromChatStyleSelector_Shape_1);
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromChatStyleSelector_ChatStyleGridView_1 == null;
      }
      
      public function get chatInputView() : RoomChatInputView
      {
         return _chatInputView;
      }
      
      public function get visible() : Boolean
      {
         return _chatInputView != null && _chatInputView.chatStyleMenuContainer != null && Boolean(_chatInputView.chatStyleMenuContainer.visible);
      }
      
      public function hide() : void
      {
         if(_chatInputView != null && _chatInputView.chatStyleMenuContainer != null)
         {
            _chatInputView.chatStyleMenuContainer.visible = false;
         }
         if(UnknownVarFromChatStyleSelector_ChatStyleGridView_1 != null && UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window != null)
         {
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window.visible = false;
         }
      }
      
      public function containsWindow(param1:IWindowModel) : Boolean
      {
         return isWindowInTree(param1,_container) || _chatInputView != null && isWindowInTree(param1,_chatInputView.chatStyleMenuContainer) || UnknownVarFromChatStyleSelector_ChatStyleGridView_1 != null && isWindowInTree(param1,UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window);
      }
      
      public function addItem(param1:int, param2:BitmapData) : void
      {
         if(UnknownVarFromChatStyleSelector_ChatStyleGridView_1 == null || UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid == null || UnknownVarFromChatStyleSelector_IWindowModel_1 == null)
         {
            return;
         }
         _entries.push(new ChatStyleGridEntry(param1,param2));
         var _loc3_:IWindowController_1 = getGridItemWindowWrapper(param2);
         if(_loc3_ == null)
         {
            return;
         }
         UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid.addGridItem(_loc3_);
         _loc3_.findChildByName("background_color").visible = false;
      }
      
      public function clear() : void
      {
         _entries.splice(0,_entries.length);
         if(UnknownVarFromChatStyleSelector_ChatStyleGridView_1 != null && UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid != null)
         {
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid.removeGridItems();
         }
      }
      
      public function get selectedStyleId() : int
      {
         if(_styleRequiresUpdate && selected)
         {
            _styleRequiresUpdate = false;
            return selected.id;
         }
         return -1;
      }
      
      public function get selectedStyleBitmap() : BitmapData
      {
         if(selected)
         {
            return selected.bitmap;
         }
         return null;
      }
      
      public function initSelection() : void
      {
         if(_entries.length == 0)
         {
            _styleRequiresUpdate = false;
            return;
         }
         selected = selected;
         _styleRequiresUpdate = false;
      }
      
      public function initFontSizeSelection(param1:int) : void
      {
         UnknownVarFromChatStyleSelector_Int_1 = clampFontSize(param1);
         updateFontSizeSelectionHighlight();
      }
      
      public function set gridColumns(param1:int) : void
      {
         if(UnknownVarFromChatStyleSelector_IWindowModel_1 == null || UnknownVarFromChatStyleSelector_ChatStyleGridView_1 == null || UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid == null)
         {
            return;
         }
         var _loc2_:int = (param1 - 1) * (UnknownVarFromChatStyleSelector_IWindowModel_1.width + 1) + UnknownVarFromChatStyleSelector_IWindowModel_1.width;
         if(param1 > 1)
         {
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid.width = _loc2_;
         }
         else
         {
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid.width = UnknownVarFromChatStyleSelector_IWindowModel_1.width + 16;
         }
      }
      
      private function set selected(param1:ChatStyleGridEntry) : void
      {
         if(param1 == null)
         {
            return;
         }
         _selected = param1;
         _styleRequiresUpdate = true;
         var _loc4_:UnknownIHabboFreeflowchatStyle1 = _chatInputView.widget.roomUi.chatStyleLibrary.getStyle(param1.id);
         if(_chatInputView.window.findChildByName("chat_bg_preview") == null)
         {
            return;
         }
         var _loc2_:Sprite = _loc4_.getNewBackgroundSprite(16777215);
         var _loc3_:IDisplayObjectWrapperController = IDisplayObjectWrapperController(_chatInputView.window.findChildByName("chat_bg_preview"));
         _loc2_.width = _loc3_.width + _loc4_.overlap.width;
         _loc2_.height = _loc3_.height + _loc4_.overlap.y + _loc4_.overlap.height;
         _loc2_.y -= _loc4_.overlap.y;
         if(!UnknownVarFromChatStyleSelector_Shape_1)
         {
            UnknownVarFromChatStyleSelector_Shape_1 = new Shape();
         }
         else
         {
            UnknownVarFromChatStyleSelector_Shape_1.graphics.clear();
         }
         UnknownVarFromChatStyleSelector_Shape_1.graphics.beginFill(16711680);
         UnknownVarFromChatStyleSelector_Shape_1.graphics.drawRect(0,0,_loc2_.width - 28,_loc2_.height);
         _loc3_.setDisplayObject(_loc2_);
         if(_loc2_.parent)
         {
            _loc2_.parent.addChild(UnknownVarFromChatStyleSelector_Shape_1);
            UnknownVarFromChatStyleSelector_Shape_1.x = _loc2_.x + 28;
            UnknownVarFromChatStyleSelector_Shape_1.y = _loc2_.y;
            _loc2_.mask = UnknownVarFromChatStyleSelector_Shape_1;
         }
         _chatInputView.setInputFieldColor(_loc4_.textFormat.color as uint);
      }
      
      private function get selected() : ChatStyleGridEntry
      {
         if(_selected == null && _entries.length > 0)
         {
            _selected = _entries[_entries.length - 1];
         }
         return _selected;
      }
      
      private function getGridItemWindowWrapper(param1:BitmapData) : IWindowController_1
      {
         if(UnknownVarFromChatStyleSelector_IWindowModel_1 == null)
         {
            return null;
         }
         var _loc2_:IWindowController_1 = IWindowController_1(UnknownVarFromChatStyleSelector_IWindowModel_1.clone());
         var _loc3_:IBitmapWrapperController = IBitmapWrapperController(_loc2_.findChildByName("bubble_preview"));
         _loc3_.bitmap = param1;
         _loc3_.center();
         _loc2_.procedure = gridItemWindowProc;
         return _loc2_;
      }
      
      private function createFontSizeOptions() : void
      {
         var _loc1_:int = 0;
         if(UnknownVarFromChatStyleSelector_ChatStyleGridView_1 == null || UnknownVarFromChatStyleSelector_ChatStyleGridView_1.fontSizeList == null || UnknownVarFromChatStyleSelector_IWindowModel_2 == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < FONT_SIZE_LABELS.length)
         {
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.fontSizeList.addListItem(getFontSizeItemWindowWrapper(FONT_SIZE_LABELS[_loc1_],_loc1_));
            _loc1_++;
         }
         updateFontSizeSelectionHighlight();
      }
      
      private function getFontSizeItemWindowWrapper(param1:String, param2:int) : IWindowController_1
      {
         if(UnknownVarFromChatStyleSelector_IWindowModel_2 == null)
         {
            return null;
         }
         var _loc3_:IWindowController_1 = IWindowController_1(UnknownVarFromChatStyleSelector_IWindowModel_2.clone());
         _loc3_.id = param2;
         ITextWindow(_loc3_.findChildByName("label")).caption = param1;
         _loc3_.procedure = fontSizeItemWindowProc;
         return _loc3_;
      }
      
      public function alignMenuToSelector() : void
      {
         if(UnknownVarFromChatStyleSelector_ChatStyleGridView_1 != null && UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window != null && Boolean(UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window.visible))
         {
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.alignToSelector(_container);
         }
      }
      
      private function buildTemplateWindow(param1:String) : IWindowModel
      {
         var _loc2_:XmlAsset = _chatInputView.widget.assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return null;
         }
         return _chatInputView.widget.windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function windowProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:* = false;
         if(param1.type == "WME_CLICK_AWAY")
         {
            hideIfClickAway(param1.related);
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromChatStyleSelector_Int_1 = clampFontSize(_chatInputView.widget.handler.container.freeFlowChat.chatFontSizeMode);
            updateFontSizeSelectionHighlight();
            _loc3_ = !_chatInputView.chatStyleMenuContainer.visible;
            _chatInputView.chatStyleMenuContainer.visible = _loc3_;
            UnknownVarFromChatStyleSelector_ChatStyleGridView_1.window.visible = _loc3_;
            if(_loc3_)
            {
               _chatInputView.hideHabbiconSelector();
            }
            alignMenuToSelector();
         }
      }
      
      private function gridItemWindowProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_CLICK_AWAY")
         {
            hideIfClickAway(param1.related);
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid.getGridItemIndex(param2);
            showBackgroundOnlyForItem(param2);
            selected = _entries[_loc3_];
            this._chatInputView.widget.handler.container.freeFlowChat.preferedChatStyle = selected.id;
         }
         if(param1.type == "WME_OVER")
         {
            IWindowController_1(param2).findChildByName("background_color").color = 4291875024;
         }
         if(param1.type == "WME_OUT")
         {
            IWindowController_1(param2).findChildByName("background_color").color = 4294967295;
         }
      }
      
      private function fontSizeItemWindowProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK_AWAY")
         {
            hideIfClickAway(param1.related);
            return;
         }
         var _loc3_:IWindowController_1 = resolveFontSizeItem(param2);
         if(_loc3_ == null)
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromChatStyleSelector_Int_1 = clampFontSize(_loc3_.id);
            _chatInputView.widget.handler.container.freeFlowChat.chatFontSizeMode = UnknownVarFromChatStyleSelector_Int_1;
            updateFontSizeSelectionHighlight();
         }
         if(param1.type == "WME_OVER")
         {
            _loc3_.findChildByName("background_color").color = 4291875024;
         }
         if(param1.type == "WME_OUT")
         {
            _loc3_.findChildByName("background_color").color = 4294967295;
         }
      }
      
      private function hideIfClickAway(param1:IWindowModel) : void
      {
         if(visible && !containsWindow(param1))
         {
            hide();
         }
      }
      
      private function showBackgroundOnlyForItem(param1:IWindowModel) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid.numGridItems)
         {
            IWindowController_1(UnknownVarFromChatStyleSelector_ChatStyleGridView_1.grid.getGridItemAt(_loc2_)).findChildByName("background_color").visible = false;
            _loc2_++;
         }
         IWindowController_1(param1).findChildByName("background_color").visible = true;
      }
      
      private function updateFontSizeSelectionHighlight() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IWindowController_1 = null;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromChatStyleSelector_ChatStyleGridView_1.fontSizeList.numListItems)
         {
            _loc1_ = IWindowController_1(UnknownVarFromChatStyleSelector_ChatStyleGridView_1.fontSizeList.getListItemAt(_loc2_));
            _loc1_.findChildByName("background_color").visible = _loc1_.id == UnknownVarFromChatStyleSelector_Int_1;
            (_loc1_.findChildByName("label") as ITextWindow).textColor = _loc1_.id == UnknownVarFromChatStyleSelector_Int_1 ? 3355443 : 10066329;
            _loc2_++;
         }
      }
      
      private function resolveFontSizeItem(param1:IWindowModel) : IWindowController_1
      {
         var _loc2_:* = param1;
         while(_loc2_ != null && _loc2_.parent != null && _loc2_.parent.parent != UnknownVarFromChatStyleSelector_ChatStyleGridView_1.fontSizeList)
         {
            _loc2_ = _loc2_.parent;
         }
         return _loc2_ as IWindowController_1;
      }
      
      private function clampFontSize(param1:int) : int
      {
         if(param1 < 0)
         {
            return 0;
         }
         if(param1 > 4)
         {
            return 4;
         }
         return param1;
      }
   }
}

