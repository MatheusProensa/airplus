package com.sulake.habbo.freeflowchat.viewer.visualization
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatBubbleWidth;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.IChatStyle;
   import com.sulake.room.object.IRoomObject;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class PooledChatBubble extends Sprite
   {
      public static const MAX_WIDTH_DEFAULT:uint = 300;
      
      private static const DESKTOP_MARGIN_LEFT:int = 85;
      
      private static const DESKTOP_MARGIN_RIGHT:int = 190;
      
      private static const LINEAR_INTERPOLATION_MS:uint = 150;
      
      private static const MAX_HEIGHT:uint = 108;
      
      private static const UnknownConstFromPooledChatBubble_Int_1:int = 28;
      
      private static const POINTER_DEFAULT_MARGIN_RIGHT:int = 15;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var UnknownVarFromPooledChatBubble_ChatItem_1:ChatItem;
      
      private var _background:Sprite;
      
      private var UnknownVarFromPooledChatBubble_Bitmap_1:Bitmap;
      
      private var UnknownVarFromPooledChatBubble_Bitmap_2:Bitmap;
      
      private var UnknownVarFromPooledChatBubble_Bitmap_3:Bitmap;
      
      private var UnknownVarFromPooledChatBubble_BitmapData_1:BitmapData;
      
      private var UnknownVarFromPooledChatBubble_TextField_1:TextField;
      
      private var _style:IChatStyle;
      
      private var UnknownVarFromPooledChatBubble_Uint_1:uint = 0;
      
      private var UnknownVarFromPooledChatBubble_Uint_2:uint;
      
      private var UnknownVarFromPooledChatBubble_Int_1:int;
      
      private var UnknownVarFromPooledChatBubble_Int_2:int;
      
      private var UnknownVarFromPooledChatBubble_Int_3:int;
      
      private var UnknownVarFromPooledChatBubble_Int_4:int;
      
      private var UnknownVarFromPooledChatBubble_Number_1:Number;
      
      private var UnknownVarFromPooledChatBubble_Number_2:Number;
      
      private var _readyToRecycle:Boolean = false;
      
      private var _roomPanOffsetX:int = 0;
      
      private var _proxyX:int;
      
      private var UnknownVarFromPooledChatBubble_Boolean_1:Boolean = false;
      
      private var _hasHitDesktopMargin:Boolean = false;
      
      private var UnknownVarFromPooledChatBubble_Sprite_1:Sprite;
      
      private var _minHeight:int = -1;
      
      public function PooledChatBubble(param1:HabboFreeFlowChat)
      {
         super();
         UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1 = param1;
         UnknownVarFromPooledChatBubble_Bitmap_1 = new Bitmap();
         UnknownVarFromPooledChatBubble_Bitmap_2 = new Bitmap();
         UnknownVarFromPooledChatBubble_Bitmap_3 = new Bitmap();
         UnknownVarFromPooledChatBubble_TextField_1 = new TextField();
         UnknownVarFromPooledChatBubble_Sprite_1 = new Sprite();
         this.addEventListener("addedToStage",onAddedToStage);
         this.addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      public function set chatItem(param1:ChatItem) : void
      {
         UnknownVarFromPooledChatBubble_ChatItem_1 = param1;
      }
      
      public function set face(param1:BitmapData) : void
      {
         UnknownVarFromPooledChatBubble_BitmapData_1 = param1;
      }
      
      public function set style(param1:IChatStyle) : void
      {
         _style = param1;
      }
      
      public function recreate(param1:String, param2:uint, param3:Boolean = false, param4:int = -1) : void
      {
         var _loc21_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:Array = null;
         var _loc10_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc18_:int = 0;
         var _loc23_:BitmapData = null;
         _background = _style.getNewBackgroundSprite(param2);
         UnknownVarFromPooledChatBubble_Bitmap_1.bitmapData = _style.pointer;
         UnknownVarFromPooledChatBubble_Boolean_1 = param3;
         var _loc11_:int = 108 * UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.chatFontSizeScale;
         var _loc22_:int = int(!!UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.roomChatSettings ? ChatBubbleWidth.accordingToRoomChatSetting(UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.roomChatSettings.bubbleWidth) : 300);
         var _loc7_:int = _loc22_ - _style.textFieldMargins.x - _style.textFieldMargins.width;
         UnknownVarFromPooledChatBubble_TextField_1.width = _loc7_;
         UnknownVarFromPooledChatBubble_TextField_1.multiline = true;
         UnknownVarFromPooledChatBubble_TextField_1.wordWrap = true;
         UnknownVarFromPooledChatBubble_TextField_1.selectable = false;
         UnknownVarFromPooledChatBubble_TextField_1.thickness = -15;
         UnknownVarFromPooledChatBubble_TextField_1.sharpness = 80;
         UnknownVarFromPooledChatBubble_TextField_1.antiAliasType = "advanced";
         UnknownVarFromPooledChatBubble_TextField_1.embedFonts = true;
         UnknownVarFromPooledChatBubble_TextField_1.gridFitType = "pixel";
         UnknownVarFromPooledChatBubble_TextField_1.cacheAsBitmap = !_style.allowHTML;
         UnknownVarFromPooledChatBubble_TextField_1.styleSheet = null;
         var _loc19_:TextFormat = createScaledTextFormat(_style.textFormat,UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.chatFontSizeScale);
         UnknownVarFromPooledChatBubble_TextField_1.defaultTextFormat = _loc19_;
         UnknownVarFromPooledChatBubble_TextField_1.styleSheet = _style.styleSheet;
         UnknownVarFromPooledChatBubble_TextField_1.addEventListener("link",onTextLinkEvent);
         var _loc6_:* = UnknownVarFromPooledChatBubble_ChatItem_1.chatType == 0;
         var _loc16_:* = UnknownVarFromPooledChatBubble_ChatItem_1.chatType == 2;
         var _loc9_:Boolean = !_loc6_ && !_loc16_ && !_style.isAnonymous;
         if(_loc9_)
         {
            UnknownVarFromPooledChatBubble_TextField_1.alpha = 0.6;
         }
         else
         {
            UnknownVarFromPooledChatBubble_TextField_1.alpha = 1;
         }
         var _loc13_:String = (_loc9_ ? "<i>" : "") + (_style.isAnonymous ? "" : "<b>" + param1 + ": </b>");
         _loc13_ = _loc13_ + (_loc16_ ? "<b>" : "") + UnknownVarFromPooledChatBubble_ChatItem_1.text + (_loc16_ ? "</b>" : "");
         _loc13_ = _loc13_ + (_loc9_ ? "</i>" : "");
         if(UnknownVarFromPooledChatBubble_ChatItem_1.links == null || UnknownVarFromPooledChatBubble_ChatItem_1.links[0] == null)
         {
            UnknownVarFromPooledChatBubble_TextField_1.htmlText = _loc13_;
         }
         else
         {
            _loc24_ = -1;
            _loc25_ = [];
            _loc21_ = 0;
            while(_loc21_ < UnknownVarFromPooledChatBubble_ChatItem_1.links.length)
            {
               _loc10_ = UnknownVarFromPooledChatBubble_ChatItem_1.links[_loc21_][0][1];
               _loc14_ = "<a href=\"" + _loc10_ + "\">" + _loc10_ + "</a>";
               _loc15_ = "{" + _loc21_ + "}";
               _loc18_ = int(UnknownVarFromPooledChatBubble_ChatItem_1.text.indexOf(_loc15_));
               _loc24_ = _loc18_ + _loc14_.length;
               _loc25_.push([_loc18_,_loc24_]);
               _loc13_ = _loc13_.replace(_loc15_,_loc14_);
               _loc21_++;
            }
            UnknownVarFromPooledChatBubble_TextField_1.htmlText = _loc13_;
         }
         _minHeight = param4;
         var _loc12_:int = Math.min(_loc22_,UnknownVarFromPooledChatBubble_TextField_1.textWidth + _style.textFieldMargins.x + _style.textFieldMargins.width);
         var _loc5_:int = UnknownVarFromPooledChatBubble_TextField_1.textHeight + _style.textFieldMargins.y + _style.textFieldMargins.height;
         var _loc20_:* = UnknownVarFromPooledChatBubble_TextField_1.numLines > 1;
         if(!_style.isSystemStyle)
         {
            _loc5_ = Math.min(_loc11_,_loc5_);
         }
         if(param4 != -1)
         {
            _loc5_ = Math.max(param4,_loc5_);
         }
         _loc12_ = Math.max(_loc12_,_background.width);
         _loc5_ = Math.max(_loc5_,_background.height);
         _background.width = _loc12_;
         _background.height = _loc5_;
         _background.x = 0;
         _background.y = 0;
         _background.cacheAsBitmap = true;
         addChild(_background);
         var _loc8_:BitmapData = _style.getEmblem(_loc20_);
         var _loc17_:Point = _style.getEmblemOffset(_loc20_);
         if(_loc8_ != null && _loc17_ != null)
         {
            UnknownVarFromPooledChatBubble_Bitmap_2.bitmapData = _loc8_;
            UnknownVarFromPooledChatBubble_Bitmap_2.x = _loc17_.x;
            UnknownVarFromPooledChatBubble_Bitmap_2.y = _loc17_.y;
            addChild(UnknownVarFromPooledChatBubble_Bitmap_2);
         }
         else
         {
            UnknownVarFromPooledChatBubble_Bitmap_2.bitmapData = null;
         }
         if(!_style.isAnonymous)
         {
            UnknownVarFromPooledChatBubble_Bitmap_1.x = Math.max(_style.getPointerLeftMargin(28),Math.min(_background.width - _style.getPointerRightMargin(15),currentUserRelativePosX));
            UnknownVarFromPooledChatBubble_Bitmap_1.y = _loc5_ - _style.pointerOffsetToBubbleBottom;
            addChild(UnknownVarFromPooledChatBubble_Bitmap_1);
         }
         if(UnknownVarFromPooledChatBubble_BitmapData_1 != null && _style.faceOffset != null)
         {
            if(UnknownVarFromPooledChatBubble_BitmapData_1.height > _loc5_)
            {
               _loc23_ = new BitmapData(UnknownVarFromPooledChatBubble_BitmapData_1.width,_loc5_);
               _loc23_.copyPixels(UnknownVarFromPooledChatBubble_BitmapData_1,new Rectangle(0,UnknownVarFromPooledChatBubble_BitmapData_1.height - _loc5_,UnknownVarFromPooledChatBubble_BitmapData_1.width,_loc5_),new Point(0,0));
            }
            else
            {
               _loc23_ = UnknownVarFromPooledChatBubble_BitmapData_1;
            }
            UnknownVarFromPooledChatBubble_Bitmap_3.bitmapData = _loc23_;
            UnknownVarFromPooledChatBubble_Bitmap_3.x = _style.faceOffset.x - _loc23_.width / 2;
            UnknownVarFromPooledChatBubble_Bitmap_3.y = Math.max(1,_style.faceOffset.y - _loc23_.height / 2);
            addChild(UnknownVarFromPooledChatBubble_Bitmap_3);
         }
         UnknownVarFromPooledChatBubble_TextField_1.width = Math.min(_loc7_,UnknownVarFromPooledChatBubble_TextField_1.textWidth + _style.textFieldMargins.width);
         UnknownVarFromPooledChatBubble_TextField_1.height = UnknownVarFromPooledChatBubble_TextField_1.textHeight + _style.textFieldMargins.height;
         UnknownVarFromPooledChatBubble_TextField_1.x = _style.textFieldMargins.x;
         UnknownVarFromPooledChatBubble_TextField_1.y = _style.textFieldMargins.y;
         addChild(UnknownVarFromPooledChatBubble_TextField_1);
         if(!_style.isSystemStyle && UnknownVarFromPooledChatBubble_TextField_1.textHeight > _loc11_)
         {
            UnknownVarFromPooledChatBubble_Sprite_1.graphics.clear();
            UnknownVarFromPooledChatBubble_Sprite_1.graphics.beginFill(16777215);
            UnknownVarFromPooledChatBubble_Sprite_1.graphics.drawRect(0,0,UnknownVarFromPooledChatBubble_TextField_1.textWidth + 5,_loc11_ - _style.textFieldMargins.height);
            UnknownVarFromPooledChatBubble_Sprite_1.graphics.endFill();
            UnknownVarFromPooledChatBubble_TextField_1.mask = UnknownVarFromPooledChatBubble_Sprite_1;
            addChild(UnknownVarFromPooledChatBubble_Sprite_1);
            UnknownVarFromPooledChatBubble_Sprite_1.x = UnknownVarFromPooledChatBubble_TextField_1.x;
            UnknownVarFromPooledChatBubble_Sprite_1.y = UnknownVarFromPooledChatBubble_TextField_1.y;
         }
         else
         {
            UnknownVarFromPooledChatBubble_Sprite_1.graphics.clear();
            UnknownVarFromPooledChatBubble_TextField_1.mask = null;
         }
         if(_style.isNotification && UnknownVarFromPooledChatBubble_Bitmap_3 != null && UnknownVarFromPooledChatBubble_Bitmap_3.bitmapData != null)
         {
            UnknownVarFromPooledChatBubble_Bitmap_3.y = Math.max(1,height / 2 - UnknownVarFromPooledChatBubble_Bitmap_3.bitmapData.height / 2);
            UnknownVarFromPooledChatBubble_Bitmap_3.x -= 0.5;
            if(!_style.isAnonymous)
            {
               UnknownVarFromPooledChatBubble_Bitmap_3.y -= UnknownVarFromPooledChatBubble_Bitmap_1.height / 2 - 1;
            }
         }
         this.cacheAsBitmap = !_style.allowHTML;
         _readyToRecycle = false;
         UnknownVarFromPooledChatBubble_Uint_1 = 0;
         visible = false;
      }
      
      public function unregister() : void
      {
         this.cacheAsBitmap = false;
         this.removeEventListener("click",onMouseClick);
         if(UnknownVarFromPooledChatBubble_Sprite_1.parent == this)
         {
            safelyRemoveChild(UnknownVarFromPooledChatBubble_Sprite_1);
         }
         safelyRemoveChild(UnknownVarFromPooledChatBubble_TextField_1);
         if(_style.faceOffset != null && UnknownVarFromPooledChatBubble_Bitmap_3.parent == this)
         {
            safelyRemoveChild(UnknownVarFromPooledChatBubble_Bitmap_3);
            UnknownVarFromPooledChatBubble_Bitmap_3.bitmapData = null;
         }
         if(UnknownVarFromPooledChatBubble_Bitmap_2.parent == this)
         {
            safelyRemoveChild(UnknownVarFromPooledChatBubble_Bitmap_2);
            UnknownVarFromPooledChatBubble_Bitmap_2.bitmapData = null;
         }
         if(UnknownVarFromPooledChatBubble_Bitmap_1 && UnknownVarFromPooledChatBubble_Bitmap_1.parent)
         {
            safelyRemoveChild(UnknownVarFromPooledChatBubble_Bitmap_1);
         }
         safelyRemoveChild(_background);
         if(UnknownVarFromPooledChatBubble_TextField_1)
         {
            UnknownVarFromPooledChatBubble_TextField_1.removeEventListener("link",onTextLinkEvent);
         }
      }
      
      private function onTextLinkEvent(param1:TextEvent) : void
      {
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc3_:TextField = null;
         var _loc2_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc6_:String = null;
         if(param1.text && param1.text.length > 0)
         {
            _loc7_ = param1.text;
            _loc4_ = "highlight/";
            if(_loc7_.indexOf(_loc4_) > -1)
            {
               _loc3_ = param1.target as TextField;
               _loc2_ = new Point(_loc3_.mouseX,_loc3_.mouseY);
               _loc2_ = _loc3_.localToGlobal(_loc2_);
               _loc5_ = new Rectangle(_loc2_.x,_loc2_.y);
               _loc6_ = _loc7_.substr(_loc7_.indexOf(_loc4_) + _loc4_.length,_loc7_.length);
               UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.windowManager.hideHint();
               UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.windowManager.showHint(_loc6_.toLocaleUpperCase(),_loc5_);
            }
            else
            {
               UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.context.createLinkEvent(param1.text);
            }
         }
      }
      
      private function safelyRemoveChild(param1:DisplayObject) : void
      {
         try
         {
            removeChild(param1);
         }
         catch(error:ArgumentError)
         {
         }
      }
      
      public function get displayedHeight() : Number
      {
         return _style.isSystemStyle ? height : Math.min(int(108 * UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.chatFontSizeScale),height);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.addEventListener("click",onMouseClick);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeEventListener("click",onMouseClick);
      }
      
      public function moveTo(param1:int, param2:int) : void
      {
         if(UnknownVarFromPooledChatBubble_Int_1 != param1 || UnknownVarFromPooledChatBubble_Int_2 != param2)
         {
            UnknownVarFromPooledChatBubble_Uint_2 = UnknownVarFromPooledChatBubble_Uint_1;
            UnknownVarFromPooledChatBubble_Int_3 = proxyX;
            UnknownVarFromPooledChatBubble_Int_4 = y;
            UnknownVarFromPooledChatBubble_Int_1 = param1;
            UnknownVarFromPooledChatBubble_Int_2 = param2;
            UnknownVarFromPooledChatBubble_Number_1 = (param1 - proxyX) / 150;
            UnknownVarFromPooledChatBubble_Number_2 = (param2 - y) / 150;
         }
      }
      
      public function warpTo(param1:int, param2:int) : void
      {
         UnknownVarFromPooledChatBubble_Int_1 = param1;
         UnknownVarFromPooledChatBubble_Int_2 = param2;
         proxyX = param1;
         y = param2;
         repositionPointer();
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = 0;
         UnknownVarFromPooledChatBubble_Uint_1 += param1;
         if(proxyX != UnknownVarFromPooledChatBubble_Int_1 || y != UnknownVarFromPooledChatBubble_Int_2)
         {
            _loc2_ = uint(UnknownVarFromPooledChatBubble_Uint_1 - UnknownVarFromPooledChatBubble_Uint_2);
            if(_loc2_ < 150 && _loc2_ > 0)
            {
               proxyX = UnknownVarFromPooledChatBubble_Int_3 + _loc2_ * UnknownVarFromPooledChatBubble_Number_1;
               y = int(UnknownVarFromPooledChatBubble_Int_4 + _loc2_ * UnknownVarFromPooledChatBubble_Number_2);
            }
            else
            {
               proxyX = UnknownVarFromPooledChatBubble_Int_1;
               y = UnknownVarFromPooledChatBubble_Int_2;
            }
         }
         repositionPointer();
         if(UnknownVarFromPooledChatBubble_Uint_1 > 150 && !visible)
         {
            visible = true;
         }
      }
      
      public function get proxyX() : int
      {
         return _proxyX;
      }
      
      public function set proxyX(param1:int) : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         _proxyX = param1;
         if(UnknownVarFromPooledChatBubble_Boolean_1 && stage)
         {
            _loc2_ = _proxyX + _roomPanOffsetX;
            _hasHitDesktopMargin = false;
            _loc3_ = stage.stageWidth - 190 - width;
            if(_loc2_ > _loc3_)
            {
               _loc2_ = _loc3_;
               _hasHitDesktopMargin = true;
            }
            if(_loc2_ < 85)
            {
               _loc2_ = 85;
               _hasHitDesktopMargin = true;
            }
            x = _loc2_;
         }
         else
         {
            x = _proxyX + _roomPanOffsetX;
         }
      }
      
      public function repositionPointer() : void
      {
         if(UnknownVarFromPooledChatBubble_Bitmap_1 && UnknownVarFromPooledChatBubble_Bitmap_1.parent)
         {
            UnknownVarFromPooledChatBubble_Bitmap_1.x = Math.max(_style.getPointerLeftMargin(28),Math.min(_background.width - _style.getPointerRightMargin(15),currentUserRelativePosX));
            UnknownVarFromPooledChatBubble_Bitmap_1.y = _background.height - _style.pointerOffsetToBubbleBottom;
         }
      }
      
      public function get readyToRecycle() : Boolean
      {
         return _readyToRecycle;
      }
      
      public function set readyToRecycle(param1:Boolean) : void
      {
         _readyToRecycle = param1;
         if(param1)
         {
            this.removeEventListener("click",onMouseClick);
         }
      }
      
      public function get timeStamp() : uint
      {
         return UnknownVarFromPooledChatBubble_ChatItem_1.timeStamp;
      }
      
      public function set component(param1:HabboFreeFlowChat) : void
      {
         UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1 = param1;
      }
      
      private function get currentUserRelativePosX() : int
      {
         return currentUserScreenPos.x - this.x;
      }
      
      public function get scrolledUserPositionX() : int
      {
         var _loc1_:Point = UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.roomEngine.getRoomCanvasScreenOffset(UnknownVarFromPooledChatBubble_ChatItem_1.roomId);
         return userScreenPos.x - (_loc1_ != null ? _loc1_.x : 0);
      }
      
      public function get userScreenPos() : Point
      {
         if(UnknownVarFromPooledChatBubble_ChatItem_1.forcedScreenLocation)
         {
            if(UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.displayObject.stage == null)
            {
               return ZERO_POINT;
            }
            return new Point(UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.displayObject.stage.stageWidth / 2 + UnknownVarFromPooledChatBubble_ChatItem_1.forcedScreenLocation,500);
         }
         return UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.getScreenPointFromRoomLocation(UnknownVarFromPooledChatBubble_ChatItem_1.roomId,UnknownVarFromPooledChatBubble_ChatItem_1.userLocation);
      }
      
      private function get currentUserScreenPos() : Point
      {
         if(UnknownVarFromPooledChatBubble_ChatItem_1.forcedScreenLocation)
         {
            return userScreenPos;
         }
         if(UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1 == null || UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.roomEngine == null)
         {
            return userScreenPos;
         }
         var _loc1_:IRoomObject = UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.roomEngine.getRoomObject(UnknownVarFromPooledChatBubble_ChatItem_1.roomId,UnknownVarFromPooledChatBubble_ChatItem_1.userId,100);
         if(_loc1_ != null)
         {
            return UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.getScreenPointFromRoomLocation(UnknownVarFromPooledChatBubble_ChatItem_1.roomId,_loc1_.getLocation());
         }
         return userScreenPos;
      }
      
      public function get roomId() : int
      {
         return UnknownVarFromPooledChatBubble_ChatItem_1.roomId;
      }
      
      public function set roomPanOffsetX(param1:int) : void
      {
         if(_roomPanOffsetX != param1)
         {
            _roomPanOffsetX = param1;
            warpTo(UnknownVarFromPooledChatBubble_Int_1,UnknownVarFromPooledChatBubble_Int_2);
         }
      }
      
      public function get roomPanOffsetX() : int
      {
         return _roomPanOffsetX;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(_style && _style.isAnonymous)
         {
            return;
         }
         if(!UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.clickHasToPropagate(param1))
         {
            UnknownVarFromPooledChatBubble_HabboFreeFlowChat_1.selectAvatarWithChatItem(UnknownVarFromPooledChatBubble_ChatItem_1);
            param1.stopImmediatePropagation();
         }
      }
      
      public function get overlap() : Rectangle
      {
         return _style.overlap;
      }
      
      public function get hasHitDesktopMargin() : Boolean
      {
         return _hasHitDesktopMargin;
      }
      
      public function get minHeight() : int
      {
         return _minHeight;
      }
      
      private function createScaledTextFormat(param1:TextFormat, param2:Number) : TextFormat
      {
         var _loc4_:TextFormat = new TextFormat();
         if(param1 != null)
         {
            _loc4_.font = param1.font;
            _loc4_.size = param1.size;
            _loc4_.color = param1.color;
            _loc4_.bold = param1.bold;
            _loc4_.italic = param1.italic;
            _loc4_.underline = param1.underline;
            _loc4_.url = param1.url;
            _loc4_.target = param1.target;
            _loc4_.align = param1.align;
            _loc4_.leftMargin = param1.leftMargin;
            _loc4_.rightMargin = param1.rightMargin;
            _loc4_.indent = param1.indent;
            _loc4_.leading = param1.leading;
            _loc4_.blockIndent = param1.blockIndent;
            _loc4_.bullet = param1.bullet;
            _loc4_.kerning = param1.kerning;
            _loc4_.letterSpacing = param1.letterSpacing;
            _loc4_.tabStops = param1.tabStops;
         }
         var _loc3_:Number = _loc4_.size == null ? 12 : Number(_loc4_.size);
         _loc4_.size = Math.max(1,_loc3_ * param2);
         return _loc4_;
      }
   }
}

