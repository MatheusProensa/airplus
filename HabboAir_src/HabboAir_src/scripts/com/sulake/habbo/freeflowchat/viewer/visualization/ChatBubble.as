package com.sulake.habbo.freeflowchat.viewer.visualization
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatBubbleWidth;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.IChatStyle;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ChatBubble extends Sprite
   {
      public static const MAX_WIDTH_DEFAULT:uint = 300;
      
      public static const UnknownConstFromChatBubble_Int_1:int = 15;
      
      private static const DESKTOP_MARGIN_LEFT:int = 85;
      
      private static const DESKTOP_MARGIN_RIGHT:int = 190;
      
      private static const LINEAR_INTERPOLATION_MS:uint = 150;
      
      private static const MAX_HEIGHT:uint = 108;
      
      private static const UnknownConstFromChatBubble_Int_2:int = 28;
      
      private static const POINTER_DEFAULT_MARGIN_RIGHT:int = 15;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var UnknownVarFromChatBubble_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var UnknownVarFromChatBubble_ChatItem_1:ChatItem;
      
      private var _background:Sprite;
      
      private var UnknownVarFromChatBubble_Bitmap_1:Bitmap;
      
      private var UnknownVarFromChatBubble_Bitmap_2:Bitmap;
      
      private var UnknownVarFromChatBubble_Bitmap_3:Bitmap;
      
      private var UnknownVarFromChatBubble_TextField_1:TextField;
      
      private var _style:IChatStyle;
      
      private var UnknownVarFromChatBubble_Uint_1:uint = 0;
      
      private var UnknownVarFromChatBubble_Uint_2:uint;
      
      private var UnknownVarFromChatBubble_Int_1:int;
      
      private var UnknownVarFromChatBubble_Int_2:int;
      
      private var UnknownVarFromChatBubble_Int_3:int;
      
      private var UnknownVarFromChatBubble_Int_4:int;
      
      private var UnknownVarFromChatBubble_Number_1:Number;
      
      private var UnknownVarFromChatBubble_Number_2:Number;
      
      private var _readyToRecycle:Boolean = false;
      
      private var UnknownVarFromChatBubble_Int_5:int = 0;
      
      private var _proxyX:int;
      
      private var UnknownVarFromChatBubble_Boolean_1:Boolean = false;
      
      private var _hasHitDesktopMargin:Boolean = false;
      
      private var UnknownVarFromChatBubble_Sprite_1:Sprite;
      
      public function ChatBubble(param1:ChatItem, param2:IChatStyle, param3:BitmapData, param4:String, param5:uint, param6:HabboFreeFlowChat, param7:int = -1, param8:Boolean = false, param9:int = -1)
      {
         var _loc26_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:Array = null;
         var _loc15_:String = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc23_:int = 0;
         var _loc28_:* = null;
         super();
         UnknownVarFromChatBubble_HabboFreeFlowChat_1 = param6;
         UnknownVarFromChatBubble_ChatItem_1 = param1;
         _style = param2;
         _background = param2.getNewBackgroundSprite(param5);
         UnknownVarFromChatBubble_Bitmap_1 = param2.isAnonymous ? null : new Bitmap(param2.pointer);
         UnknownVarFromChatBubble_Boolean_1 = param8;
         var _loc16_:int = 108 * param6.chatFontSizeScale;
         var _loc27_:int = 300;
         if(param7 != -1)
         {
            _loc27_ = ChatBubbleWidth.accordingToRoomChatSetting(param7);
         }
         else if(param6.roomChatSettings)
         {
            _loc27_ = ChatBubbleWidth.accordingToRoomChatSetting(param6.roomChatSettings.bubbleWidth);
         }
         _loc27_ -= 15;
         this.cacheAsBitmap = true;
         var _loc12_:int = _loc27_ - param2.textFieldMargins.x - param2.textFieldMargins.width;
         UnknownVarFromChatBubble_TextField_1 = new TextField();
         UnknownVarFromChatBubble_TextField_1.width = _loc12_;
         UnknownVarFromChatBubble_TextField_1.multiline = true;
         UnknownVarFromChatBubble_TextField_1.wordWrap = true;
         UnknownVarFromChatBubble_TextField_1.selectable = false;
         UnknownVarFromChatBubble_TextField_1.thickness = -15;
         UnknownVarFromChatBubble_TextField_1.sharpness = 80;
         UnknownVarFromChatBubble_TextField_1.antiAliasType = "advanced";
         UnknownVarFromChatBubble_TextField_1.embedFonts = true;
         UnknownVarFromChatBubble_TextField_1.gridFitType = "pixel";
         UnknownVarFromChatBubble_TextField_1.cacheAsBitmap = true;
         var _loc24_:TextFormat = createScaledTextFormat(param2.textFormat,param6.chatFontSizeScale);
         UnknownVarFromChatBubble_TextField_1.defaultTextFormat = _loc24_;
         UnknownVarFromChatBubble_TextField_1.styleSheet = _style.styleSheet;
         UnknownVarFromChatBubble_TextField_1.addEventListener("link",onTextLinkEvent);
         var _loc11_:* = param1.chatType == 0;
         var _loc21_:* = param1.chatType == 2;
         var _loc14_:Boolean = !_loc11_ && !_loc21_ && !_style.isAnonymous;
         if(_loc14_)
         {
            UnknownVarFromChatBubble_TextField_1.alpha = 0.6;
         }
         var _loc18_:String = (_loc14_ ? "<i>" : "") + (_style.isAnonymous ? "" : "<b>" + param4 + ": </b>");
         _loc18_ = _loc18_ + (_loc21_ ? "<b>" : "") + param1.text + (_loc21_ ? "</b>" : "");
         _loc18_ = _loc18_ + (_loc14_ ? "</i>" : "");
         if(param1.links == null || param1.links[0] == null)
         {
            UnknownVarFromChatBubble_TextField_1.htmlText = _loc18_;
         }
         else
         {
            _loc29_ = -1;
            _loc30_ = [];
            _loc26_ = 0;
            while(_loc26_ < param1.links.length)
            {
               _loc15_ = param1.links[_loc26_][0][1];
               _loc19_ = "<a href=\"" + _loc15_ + "\">" + _loc15_ + "</a>";
               _loc20_ = "{" + _loc26_ + "}";
               _loc23_ = int(param1.text.indexOf(_loc20_));
               _loc29_ = _loc23_ + _loc19_.length;
               _loc30_.push([_loc23_,_loc29_]);
               _loc18_ = _loc18_.replace(_loc20_,_loc19_);
               _loc26_++;
            }
            UnknownVarFromChatBubble_TextField_1.htmlText = _loc18_;
         }
         var _loc17_:int = Math.min(_loc27_,UnknownVarFromChatBubble_TextField_1.textWidth + param2.textFieldMargins.x + param2.textFieldMargins.width);
         var _loc10_:int = UnknownVarFromChatBubble_TextField_1.textHeight + param2.textFieldMargins.y + param2.textFieldMargins.height;
         var _loc25_:* = UnknownVarFromChatBubble_TextField_1.numLines > 1;
         if(!_style.isSystemStyle)
         {
            _loc10_ = Math.min(_loc16_,_loc10_);
         }
         if(param9 != -1)
         {
            _loc10_ = Math.max(param9,_loc10_);
         }
         _loc17_ = Math.max(_loc17_,_background.width);
         _loc10_ = Math.max(_loc10_,_background.height);
         _background.width = _loc17_;
         _background.height = _loc10_;
         _background.x = 0;
         _background.y = 0;
         _background.cacheAsBitmap = true;
         addChild(_background);
         var _loc13_:BitmapData = param2.getEmblem(_loc25_);
         var _loc22_:Point = param2.getEmblemOffset(_loc25_);
         if(_loc13_ != null && _loc22_ != null)
         {
            UnknownVarFromChatBubble_Bitmap_2 = new Bitmap(_loc13_);
            UnknownVarFromChatBubble_Bitmap_2.x = _loc22_.x;
            UnknownVarFromChatBubble_Bitmap_2.y = _loc22_.y;
            addChild(UnknownVarFromChatBubble_Bitmap_2);
         }
         if(!_style.isAnonymous)
         {
            UnknownVarFromChatBubble_Bitmap_1.x = Math.max(param2.getPointerLeftMargin(28),Math.min(param2.getPointerRightMargin(15),userRelativePosX));
            UnknownVarFromChatBubble_Bitmap_1.y = _loc10_ - param2.pointerOffsetToBubbleBottom;
            addChild(UnknownVarFromChatBubble_Bitmap_1);
         }
         if(param3 != null && param2.faceOffset != null)
         {
            if(param3.height > _loc10_)
            {
               _loc28_ = new BitmapData(param3.width,_loc10_);
               _loc28_.copyPixels(param3,new Rectangle(0,param3.height - _loc10_,param3.width,_loc10_),new Point(0,0));
            }
            else
            {
               _loc28_ = param3;
            }
            UnknownVarFromChatBubble_Bitmap_3 = new Bitmap(_loc28_);
            UnknownVarFromChatBubble_Bitmap_3.x = param2.faceOffset.x - _loc28_.width / 2;
            UnknownVarFromChatBubble_Bitmap_3.y = Math.max(1,param2.faceOffset.y - _loc28_.height / 2);
            addChild(UnknownVarFromChatBubble_Bitmap_3);
         }
         UnknownVarFromChatBubble_TextField_1.width = Math.min(_loc12_,UnknownVarFromChatBubble_TextField_1.textWidth + _style.textFieldMargins.width);
         UnknownVarFromChatBubble_TextField_1.height = UnknownVarFromChatBubble_TextField_1.textHeight + _style.textFieldMargins.height;
         UnknownVarFromChatBubble_TextField_1.x = param2.textFieldMargins.x;
         UnknownVarFromChatBubble_TextField_1.y = param2.textFieldMargins.y;
         addChild(UnknownVarFromChatBubble_TextField_1);
         if(_style.isNotification && UnknownVarFromChatBubble_Bitmap_3 != null)
         {
            UnknownVarFromChatBubble_Bitmap_3.y = Math.max(1,height / 2 - _loc28_.height / 2);
         }
         if(!_style.isSystemStyle && UnknownVarFromChatBubble_TextField_1.textHeight > _loc16_)
         {
            UnknownVarFromChatBubble_Sprite_1 = new Sprite();
            UnknownVarFromChatBubble_Sprite_1.graphics.clear();
            UnknownVarFromChatBubble_Sprite_1.graphics.beginFill(16777215);
            UnknownVarFromChatBubble_Sprite_1.graphics.drawRect(0,0,UnknownVarFromChatBubble_TextField_1.textWidth + 5,_loc16_ - param2.textFieldMargins.height);
            UnknownVarFromChatBubble_TextField_1.mask = UnknownVarFromChatBubble_Sprite_1;
            addChild(UnknownVarFromChatBubble_Sprite_1);
         }
         this.addEventListener("addedToStage",onAddedToStage);
      }
      
      public function dispose() : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         this.removeEventListener("click",onMouseClick);
         if(UnknownVarFromChatBubble_Sprite_1)
         {
            removeChild(UnknownVarFromChatBubble_Sprite_1);
         }
         if(UnknownVarFromChatBubble_TextField_1)
         {
            UnknownVarFromChatBubble_TextField_1.removeEventListener("link",onTextLinkEvent);
         }
         removeChild(UnknownVarFromChatBubble_TextField_1);
         if(UnknownVarFromChatBubble_Bitmap_3 != null && _style.faceOffset != null)
         {
            removeChild(UnknownVarFromChatBubble_Bitmap_3);
         }
         if(UnknownVarFromChatBubble_Bitmap_2 != null && UnknownVarFromChatBubble_Bitmap_2.parent != null)
         {
            removeChild(UnknownVarFromChatBubble_Bitmap_2);
         }
         if(UnknownVarFromChatBubble_Bitmap_1 && UnknownVarFromChatBubble_Bitmap_1.parent)
         {
            removeChild(UnknownVarFromChatBubble_Bitmap_1);
         }
         removeChild(_background);
         UnknownVarFromChatBubble_Sprite_1 = null;
         UnknownVarFromChatBubble_TextField_1 = null;
         UnknownVarFromChatBubble_Bitmap_2 = null;
         UnknownVarFromChatBubble_Bitmap_3 = null;
         UnknownVarFromChatBubble_Bitmap_1 = null;
         _background = null;
         _style = null;
      }
      
      private function onTextLinkEvent(param1:TextEvent) : void
      {
         if(param1.text && param1.text.length > 0)
         {
            UnknownVarFromChatBubble_HabboFreeFlowChat_1.context.createLinkEvent(param1.text);
         }
      }
      
      public function get displayedHeight() : Number
      {
         return _style.isSystemStyle ? height : Math.min(int(108 * UnknownVarFromChatBubble_HabboFreeFlowChat_1.chatFontSizeScale),height);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.addEventListener("click",onMouseClick);
      }
      
      public function moveTo(param1:int, param2:int) : void
      {
         if(UnknownVarFromChatBubble_Int_1 != param1 || UnknownVarFromChatBubble_Int_2 != param2)
         {
            UnknownVarFromChatBubble_Uint_2 = UnknownVarFromChatBubble_Uint_1;
            UnknownVarFromChatBubble_Int_3 = proxyX;
            UnknownVarFromChatBubble_Int_4 = y;
            UnknownVarFromChatBubble_Int_1 = param1;
            UnknownVarFromChatBubble_Int_2 = param2;
            UnknownVarFromChatBubble_Number_1 = (param1 - proxyX) / 150;
            UnknownVarFromChatBubble_Number_2 = (param2 - y) / 150;
         }
      }
      
      public function warpTo(param1:int, param2:int) : void
      {
         UnknownVarFromChatBubble_Int_1 = param1;
         UnknownVarFromChatBubble_Int_2 = param2;
         proxyX = param1;
         y = param2;
         repositionPointer();
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = 0;
         UnknownVarFromChatBubble_Uint_1 += param1;
         if(proxyX != UnknownVarFromChatBubble_Int_1 || y != UnknownVarFromChatBubble_Int_2)
         {
            _loc2_ = uint(UnknownVarFromChatBubble_Uint_1 - UnknownVarFromChatBubble_Uint_2);
            if(_loc2_ < 150)
            {
               proxyX = UnknownVarFromChatBubble_Int_3 + _loc2_ * UnknownVarFromChatBubble_Number_1;
               y = int(UnknownVarFromChatBubble_Int_4 + _loc2_ * UnknownVarFromChatBubble_Number_2);
            }
            else
            {
               proxyX = UnknownVarFromChatBubble_Int_1;
               y = UnknownVarFromChatBubble_Int_2;
            }
         }
         repositionPointer();
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
         if(UnknownVarFromChatBubble_Boolean_1 && stage)
         {
            _loc2_ = _proxyX + UnknownVarFromChatBubble_Int_5;
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
            x = _proxyX + UnknownVarFromChatBubble_Int_5;
         }
      }
      
      public function repositionPointer() : void
      {
         if(UnknownVarFromChatBubble_Bitmap_1 && UnknownVarFromChatBubble_Bitmap_1.parent)
         {
            UnknownVarFromChatBubble_Bitmap_1.x = Math.max(_style.getPointerLeftMargin(28),Math.min(_background.width - _style.getPointerRightMargin(15),userRelativePosX));
            UnknownVarFromChatBubble_Bitmap_1.y = _background.height - _style.pointerOffsetToBubbleBottom;
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
         return UnknownVarFromChatBubble_ChatItem_1.timeStamp;
      }
      
      public function set component(param1:HabboFreeFlowChat) : void
      {
         UnknownVarFromChatBubble_HabboFreeFlowChat_1 = param1;
      }
      
      private function get userRelativePosX() : int
      {
         return userScreenPos.x - this.x;
      }
      
      public function get userScreenPos() : Point
      {
         if(UnknownVarFromChatBubble_ChatItem_1.forcedScreenLocation)
         {
            if(UnknownVarFromChatBubble_HabboFreeFlowChat_1.displayObject.stage == null)
            {
               return ZERO_POINT;
            }
            return new Point(UnknownVarFromChatBubble_HabboFreeFlowChat_1.displayObject.stage.stageWidth / 2 + UnknownVarFromChatBubble_ChatItem_1.forcedScreenLocation,500);
         }
         return UnknownVarFromChatBubble_HabboFreeFlowChat_1.getScreenPointFromRoomLocation(UnknownVarFromChatBubble_ChatItem_1.roomId,UnknownVarFromChatBubble_ChatItem_1.userLocation);
      }
      
      public function get roomId() : int
      {
         return UnknownVarFromChatBubble_ChatItem_1.roomId;
      }
      
      public function set roomPanOffsetX(param1:int) : void
      {
         if(UnknownVarFromChatBubble_Int_5 != param1)
         {
            UnknownVarFromChatBubble_Int_5 = param1;
            warpTo(UnknownVarFromChatBubble_Int_1,UnknownVarFromChatBubble_Int_2);
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(_style && _style.isAnonymous)
         {
            return;
         }
         if(!UnknownVarFromChatBubble_HabboFreeFlowChat_1.clickHasToPropagate(param1))
         {
            UnknownVarFromChatBubble_HabboFreeFlowChat_1.selectAvatarWithChatItem(UnknownVarFromChatBubble_ChatItem_1);
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
      
      public function drawToBitmap(param1:BitmapData) : void
      {
         param1.draw(this);
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

