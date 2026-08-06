package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Matrix;
   
   public class IlluminaChatBubbleWidget implements IIlluminaChatBubbleWidget
   {
      public static const TYPE:String = "illumina_chat_bubble";
      
      private static const UnknownConstFromIlluminaChatBubbleWidget_String_1:String = "illumina_chat_bubble:flipped";
      
      private static const USER_NAME_KEY:String = "illumina_chat_bubble:user_name";
      
      private static const FIGURE_KEY:String = "illumina_chat_bubble:figure";
      
      private static const MESSAGE_KEY:String = "illumina_chat_bubble:message";
      
      private static const UnknownConstFromIlluminaChatBubbleWidget_Int_1:int = 80;
      
      private static const UnknownConstFromIlluminaChatBubbleWidget_Int_2:int = 2;
      
      private static const UnknownConstFromIlluminaChatBubbleWidget_Int_3:int = -1;
      
      private static const HABBICON_DIRECTION_RIGHT:int = 1;
      
      private static const PENDING_MESSAGE_BLEND:Number = 0.45;
      
      private static var RESIZING_OFFSETS:int = 10;
      
      private static const FLIPPED_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:flipped",false,"Boolean");
      
      private static const USER_NAME_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:user_name","","String");
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:figure","","String");
      
      private static const MESSAGE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:message","","String");
      
      private var UnknownVarFromIlluminaChatBubbleWidget_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_1:IWindowController_1;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2:IWindowController_1;
      
      private var _flipped:Boolean = Boolean(FLIPPED_DEFAULT.value);
      
      private var _userName:ILabelWindow;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1:IWindowModel;
      
      private var _avatarWidget:IAvatarImageWidget;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2:IWindowModel;
      
      private var _postTime:IUpdatingTimeStampWidget;
      
      private var _offline:IRegionWindow;
      
      private var _arrowPoint:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_Boolean_1:Boolean;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_2:IItemListWindow;
      
      private var _messages:Vector.<IlluminaChatBubbleMessage> = new Vector.<IlluminaChatBubbleMessage>(0);
      
      private var UnknownVarFromIlluminaChatBubbleWidget_Array_1:Array = [];
      
      private var UnknownVarFromIlluminaChatBubbleWidget_Boolean_2:Boolean;
      
      private var UnknownVarFromIlluminaChatBubbleWidget_Int_1:int = 0;
      
      public function IlluminaChatBubbleWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromIlluminaChatBubbleWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_chat_bubble_xml").content as XML) as IWindowController_1;
         UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1 = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("message_container") as IItemListWindow;
         UnknownVarFromIlluminaChatBubbleWidget_ITextWindow_1 = UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.getListItemByName("message_template") as ITextWindow;
         UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.removeListItem(UnknownVarFromIlluminaChatBubbleWidget_ITextWindow_1);
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_1 = UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.getListItemByName("habbicon_template") as IWindowController_1;
         UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.removeListItem(UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_1);
         UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_2 = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("spaced_message_container") as IItemListWindow;
         _userName = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("user_name") as ILabelWindow;
         var _loc3_:IWidgetWindowController = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("user_avatar") as IWidgetWindowController;
         UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1 = _loc3_.parent;
         _avatarWidget = _loc3_.widget as IAvatarImageWidget;
         UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2 = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("bubble_wrapper");
         _postTime = IWidgetWindowController(UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("post_time")).widget as IUpdatingTimeStampWidget;
         _offline = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("offline_placeholder") as IRegionWindow;
         _offline.height = 0;
         _arrowPoint = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("arrow_point") as IStaticBitmapWrapperWindow;
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.findChildByName("message_region").setParamFlag(1,false);
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.procedure = rootProcedure;
         userName = String(USER_NAME_DEFAULT.value);
         figure = String(FIGURE_DEFAULT.value);
         setMessages(getMessagesFromProperty(String(MESSAGE_DEFAULT.value)));
         UnknownVarFromIlluminaChatBubbleWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2;
         UnknownVarFromIlluminaChatBubbleWidget_IWidgetWindowController_1.setParamFlag(147456);
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.width = UnknownVarFromIlluminaChatBubbleWidget_IWidgetWindowController_1.width;
      }
      
      public static function getMessagesFromProperty(param1:String) : Array
      {
         var _loc2_:Array = param1.split("\t");
         if(_loc2_.length == 1 && _loc2_[0] == "")
         {
            return [];
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2 != null)
            {
               UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.dispose();
               UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2 = null;
            }
            HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
            if(UnknownVarFromIlluminaChatBubbleWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromIlluminaChatBubbleWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromIlluminaChatBubbleWidget_IWidgetWindowController_1 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(FLIPPED_DEFAULT.withValue(flipped));
         _loc1_.push(USER_NAME_DEFAULT.withValue(userName));
         _loc1_.push(FIGURE_DEFAULT.withValue(figure));
         _loc1_.push(MESSAGE_DEFAULT.withValue(getSerializedMessages().join("\t")));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_chat_bubble:flipped":
                  flipped = Boolean(_loc2_.value);
                  break;
               case "illumina_chat_bubble:user_name":
                  userName = String(_loc2_.value);
                  break;
               case "illumina_chat_bubble:figure":
                  figure = String(_loc2_.value);
                  break;
               case "illumina_chat_bubble:message":
                  setMessages(getMessagesFromProperty(String(_loc2_.value)));
                  break;
            }
         }
      }
      
      public function get flipped() : Boolean
      {
         return _flipped;
      }
      
      public function set flipped(param1:Boolean) : void
      {
         if(_flipped == param1)
         {
            return;
         }
         _flipped = param1;
         refresh();
      }
      
      public function get userName() : String
      {
         return _userName.caption.slice(0,-1);
      }
      
      public function set userName(param1:String) : void
      {
         _userName.caption = param1 + ":";
      }
      
      public function get userId() : int
      {
         return _avatarWidget.userId;
      }
      
      public function set userId(param1:int) : void
      {
         _avatarWidget.userId = param1;
      }
      
      public function get figure() : String
      {
         return _avatarWidget.figure;
      }
      
      public function set figure(param1:String) : void
      {
         _avatarWidget.figure = param1;
      }
      
      public function get timeStamp() : Number
      {
         return _postTime.timeStamp;
      }
      
      public function set timeStamp(param1:Number) : void
      {
         _postTime.timeStamp = param1;
      }
      
      public function set friendOnlineStatus(param1:Boolean) : void
      {
         _offline.height = !param1 ? 16 : 0;
      }
      
      public function refresh() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IWindowModel = null;
         var _loc4_:ITextWindow = null;
         if(UnknownVarFromIlluminaChatBubbleWidget_Boolean_1)
         {
            return;
         }
         UnknownVarFromIlluminaChatBubbleWidget_Boolean_1 = true;
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.limits.minWidth = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.width;
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.limits.maxWidth = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.width;
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.height = UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2.bottom;
         UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2.width = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.width - UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1.width;
         var _loc3_:int = UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2.width / RESIZING_OFFSETS;
         if(_loc3_ != UnknownVarFromIlluminaChatBubbleWidget_Int_1)
         {
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.numListItems)
            {
               _loc1_ = UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.getListItemAt(_loc2_);
               _loc4_ = _loc1_ as ITextWindow;
               if(_loc4_ != null)
               {
                  _loc4_.width = UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2.width - 5;
               }
               else
               {
                  _loc1_.width = 80;
                  _loc1_.height = 80;
               }
               _loc2_ += 1;
            }
            UnknownVarFromIlluminaChatBubbleWidget_Int_1 = _loc3_;
         }
         UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.width = UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2.width;
         UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_2.width = UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2.width;
         _avatarWidget.direction = _flipped ? 4 : 2;
         if(_flipped)
         {
            UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1.x = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.width - UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1.width;
            _arrowPoint.zoomX = 1;
            _arrowPoint.x = UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1.x;
            UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2.x = 0;
         }
         else
         {
            UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1.x = 0;
            _arrowPoint.zoomX = -1;
            _arrowPoint.x = UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1.right - _arrowPoint.width;
            UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_2.x = UnknownVarFromIlluminaChatBubbleWidget_IWindowModel_1.right;
         }
         UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_2.limits.setEmpty();
         _arrowPoint.invalidate();
         UnknownVarFromIlluminaChatBubbleWidget_Boolean_1 = false;
      }
      
      private function rootProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         switch(param1.type)
         {
            case "WE_RESIZED":
               refresh();
               break;
            case "WE_CHILD_RESIZED":
               refresh();
               break;
            case "WME_CLICK":
               if(userId > 0 && param2.name == "user_name_region")
               {
                  _windowManager.communication.connection.send(new GetExtendedProfileMessageComposer(userId));
               }
         }
      }
      
      public function get numMessages() : int
      {
         return _messages.length;
      }
      
      public function getMessage(param1:int) : IlluminaChatBubbleMessage
      {
         return _messages[param1];
      }
      
      public function setMessage(param1:int, param2:*) : void
      {
         var _loc4_:IWindowModel = null;
         var _loc5_:IlluminaChatBubbleMessage = normalizeMessage(param2);
         while(param1 >= numMessages)
         {
            _messages.push(IlluminaChatBubbleMessage.text(""));
            UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.addListItem(createMessageWindow(_messages[_messages.length - 1]));
            UnknownVarFromIlluminaChatBubbleWidget_Array_1.push(0);
         }
         var _loc6_:int = int(UnknownVarFromIlluminaChatBubbleWidget_Array_1[param1]);
         var _loc3_:IlluminaChatBubbleMessage = _messages[param1];
         _messages[param1] = _loc5_;
         if(_loc3_.type != _loc5_.type)
         {
            _loc4_ = UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.removeListItemAt(param1);
            _loc4_.dispose();
            UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.addListItemAt(createMessageWindow(_loc5_),param1);
         }
         else
         {
            updateMessageWindow(param1,_loc5_);
         }
         setAwaitingConfirmationId(param1,_loc6_);
      }
      
      public function appendMessage(param1:*, param2:Boolean = false, param3:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc4_:IlluminaChatBubbleMessage = normalizeMessage(param1);
         if(param2)
         {
            _loc5_ = 0;
            _messages.splice(_loc5_,0,_loc4_);
            UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.addListItemAt(createMessageWindow(_loc4_),0);
            UnknownVarFromIlluminaChatBubbleWidget_Array_1.splice(_loc5_,0,param3);
         }
         else
         {
            _loc5_ = numMessages;
            _messages.push(_loc4_);
            UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.addListItem(createMessageWindow(_loc4_));
            UnknownVarFromIlluminaChatBubbleWidget_Array_1.push(param3);
         }
         setAwaitingConfirmationId(_loc5_,param3);
      }
      
      private function setMessages(param1:Array) : void
      {
         disposeMessageWindows();
         _messages.length = 0;
         UnknownVarFromIlluminaChatBubbleWidget_Array_1.length = 0;
         for each(var _loc2_ in param1)
         {
            appendMessage(IlluminaChatBubbleMessage.text(_loc2_));
         }
      }
      
      public function getMessages() : Array
      {
         return getSerializedMessages();
      }
      
      private function getSerializedMessages() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:IlluminaChatBubbleMessage = null;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < numMessages)
         {
            _loc3_ = getMessage(_loc2_);
            _loc1_.push(_loc3_.type == 0 ? _loc3_.textValue : "");
            _loc2_ += 1;
         }
         return _loc1_;
      }
      
      public function setAwaitingConfirmationId(param1:int, param2:int) : void
      {
         applyConfirmationVisual(param1,param2);
         UnknownVarFromIlluminaChatBubbleWidget_Array_1[param1] = param2;
      }
      
      public function clearAwaitingConfirmationId(param1:int) : void
      {
         applyConfirmationVisual(param1,0);
         UnknownVarFromIlluminaChatBubbleWidget_Array_1[param1] = 0;
      }
      
      public function getAwaitingConfirmationId(param1:int) : int
      {
         return UnknownVarFromIlluminaChatBubbleWidget_Array_1[param1];
      }
      
      private function createMessageWindow(param1:IlluminaChatBubbleMessage) : IWindowModel
      {
         if(param1.type == 1)
         {
            return createHabbiconMessage(param1);
         }
         var _loc2_:ITextWindow = UnknownVarFromIlluminaChatBubbleWidget_ITextWindow_1.clone() as ITextWindow;
         _loc2_.caption = param1.textValue;
         return _loc2_;
      }
      
      private function normalizeMessage(param1:*) : IlluminaChatBubbleMessage
      {
         if(param1 is IlluminaChatBubbleMessage)
         {
            return param1 as IlluminaChatBubbleMessage;
         }
         return IlluminaChatBubbleMessage.text(param1 == null ? "" : param1);
      }
      
      private function createHabbiconMessage(param1:IlluminaChatBubbleMessage) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = UnknownVarFromIlluminaChatBubbleWidget_IWindowController_1_1.clone() as IWindowController_1;
         _loc2_.visible = true;
         _loc2_.width = 80;
         _loc2_.height = 80;
         renderHabbicon(_loc2_,param1.habbiconId);
         return _loc2_;
      }
      
      private function updateMessageWindow(param1:int, param2:IlluminaChatBubbleMessage) : void
      {
         var _loc3_:IWindowModel = UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.getListItemAt(param1);
         if(param2.type == 1)
         {
            renderHabbicon(_loc3_ as IWindowController_1,param2.habbiconId);
         }
         else
         {
            _loc3_.caption = param2.textValue;
         }
      }
      
      private function renderHabbicon(param1:IWindowController_1, param2:int) : void
      {
         param1.width = 80;
         param1.height = 80;
         var _loc3_:IBitmapWrapperController = param1.findChildByName("habbicon_bitmap") as IBitmapWrapperController;
         _loc3_.disposesBitmap = true;
         _loc3_.bitmap = createHabbiconBitmap(param2);
      }
      
      private function createHabbiconBitmap(param1:int) : BitmapData
      {
         var _loc4_:Matrix = null;
         var _loc3_:BitmapData = new BitmapData(80,80,true,0);
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(param1,false);
         if(_loc2_ == null)
         {
            if(!UnknownVarFromIlluminaChatBubbleWidget_Boolean_2)
            {
               HabbiconAssetManager.addEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
               UnknownVarFromIlluminaChatBubbleWidget_Boolean_2 = true;
            }
            return _loc3_;
         }
         _loc4_ = new Matrix();
         if(shouldMirrorHabbicon(param1))
         {
            _loc4_.scale(-2,2);
            _loc4_.translate(_loc2_.width * 2,0);
         }
         else
         {
            _loc4_.scale(2,2);
         }
         _loc3_.draw(_loc2_,_loc4_,null,null,null,false);
         return _loc3_;
      }
      
      private function shouldMirrorHabbicon(param1:int) : Boolean
      {
         var _loc3_:int = _flipped ? -1 : 1;
         var _loc2_:int = HabbiconAssetManager.getDirection(param1);
         return _loc3_ != 0 && _loc2_ != 0 && _loc3_ != _loc2_;
      }
      
      private function onHabbiconAssetsLoaded(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IlluminaChatBubbleMessage = null;
         HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
         UnknownVarFromIlluminaChatBubbleWidget_Boolean_2 = false;
         if(_disposed)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < numMessages)
         {
            _loc3_ = _messages[_loc2_];
            if(_loc3_.type == 1)
            {
               renderHabbicon(UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.getListItemAt(_loc2_) as IWindowController_1,_loc3_.habbiconId);
            }
            _loc2_ += 1;
         }
      }
      
      private function applyConfirmationVisual(param1:int, param2:int) : void
      {
         var _loc3_:IWindowModel = UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.getListItemAt(param1);
         var _loc5_:ITextWindow = _loc3_ as ITextWindow;
         var _loc4_:Number = param2 > 0 ? 0.45 : 1;
         if(_loc5_ != null)
         {
            _loc5_.textColor = param2 > 0 ? 9079434 : 0;
         }
         else
         {
            _loc3_.blend = _loc4_;
            (_loc3_ as IWindowController_1).findChildByName("habbicon_bitmap").blend = _loc4_;
         }
      }
      
      private function disposeMessageWindows() : void
      {
         var _loc1_:IWindowModel = null;
         while(UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.numListItems > 0)
         {
            _loc1_ = UnknownVarFromIlluminaChatBubbleWidget_IItemListWindow_1.removeListItemAt(0);
            _loc1_.dispose();
         }
      }
   }
}

