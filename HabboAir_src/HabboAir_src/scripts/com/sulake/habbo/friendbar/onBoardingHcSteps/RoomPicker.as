package com.sulake.habbo.friendbar.onBoardingHcSteps
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.nux.SelectInitialRoomEvent;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateHomeRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nux.SelectInitialRoomComposer;
   import com.sulake.habbo.communication.messages.parser.nux.SelectInitialRoomMessageParser;
   import com.sulake.habbo.friendbar.onBoardingHc.OnBoardingHcFlow;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.ColouredButton;
   import onBoardingHcUi.LoaderUI;
   
   public class RoomPicker implements IComponentInterfaceQueue
   {
      private static const room_image_border_png:Class = room_image_border_new_1_png;
      
      private static const room_selected_icon_png:Class = icon_yes_1_png;
      
      private var _roomImages:Array = [];
      
      private var _numOfRooms:int;
      
      private var _newUserFlow:OnBoardingHcFlow;
      
      private var _container:Sprite;
      
      private var UnknownVarFromRoomPicker_Sprite_1:Sprite;
      
      private var UnknownVarFromRoomPicker_Int_1:int = 1;
      
      private var _roomTypes:Array;
      
      private var UnknownVarFromRoomPicker_TextField_1:TextField;
      
      private var _roomName:TextField;
      
      private var UnknownVarFromRoomPicker_Button_1:Button;
      
      private var _roomImageContainers:Array = [];
      
      private var UnknownVarFromRoomPicker_Bitmap_1:Bitmap;
      
      private var UnknownVarFromRoomPicker_Int_2:int = 0;
      
      private var _spaceBetweenImages:int = 30;
      
      private var UnknownVarFromRoomPicker_IMessageEvent_1:IMessageEvent;
      
      public function RoomPicker(param1:OnBoardingHcFlow, param2:Sprite)
      {
         super();
         _newUserFlow = param1;
         _container = param2;
         UnknownVarFromRoomPicker_IMessageEvent_1 = param1.communicationManager.addHabboConnectionMessageEvent(new SelectInitialRoomEvent(onSelectInitialRoomResponse));
      }
      
      private static function get galleryUrl() : String
      {
         return "https://images.habbo.com/c_images/nux/";
      }
      
      private function onSelectInitialRoomResponse(param1:SelectInitialRoomEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:SelectInitialRoomMessageParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.roomId > 0)
         {
            _newUserFlow.communicationManager.connection.send(new UpdateHomeRoomMessageComposer(_loc2_.roomId));
         }
         _newUserFlow.roomPickingCompleted();
      }
      
      public function fetchThumbnails() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Loader = null;
         var _loc2_:URLRequest = null;
         _roomTypes = _newUserFlow.getProperty("new.user.flow.roomTypes","10,11,12").split(",");
         _numOfRooms = _roomTypes.length;
         _loc3_ = 0;
         while(_loc3_ < _numOfRooms)
         {
            _loc1_ = new Loader();
            _loc2_ = new URLRequest(galleryUrl + "nux_room_" + _roomTypes[_loc3_] + "_round.png");
            _loc1_.load(_loc2_);
            _loc1_.contentLoaderInfo.addEventListener("complete",roomImageLoadCompleteHandler);
            _roomImages.push(_loc1_);
            _loc3_++;
         }
      }
      
      public function init() : void
      {
         if(_roomTypes == null)
         {
            fetchThumbnails();
         }
      }
      
      public function initView() : void
      {
         var _loc6_:int = 0;
         var _loc3_:Sprite = null;
         var _loc1_:Loader = null;
         var _loc2_:int = 0;
         var _loc5_:TextField = LoaderUI.createTextField("headerText",24,8309486,false,true,false,false);
         _loc5_.width = 500;
         _loc5_.thickness = 50;
         _container.addChild(_loc5_);
         _loc5_.htmlText = _newUserFlow.getLocalization("onboarding.room.information","Choose your first room. This room gets you started. You can create more free rooms later, if you like.");
         _loc5_.multiline = true;
         _loc5_.x = 25;
         _loc5_.y = -70;
         _loc6_ = 0;
         while(_loc6_ < _numOfRooms)
         {
            _loc3_ = new Sprite();
            _loc1_ = _roomImages[_loc6_] as Loader;
            if(_loc1_ != null)
            {
               _loc3_.addChild(_loc1_);
            }
            _container.addChild(_loc3_);
            _roomImageContainers.push(_loc3_);
            _loc3_.name = String(_loc6_ + 1);
            _loc3_.addEventListener("click",onRoomClick);
            _loc2_ = (_loc6_ + 1) * _spaceBetweenImages + _loc6_ * 280;
            _loc3_.x = _loc2_;
            _loc3_.y = 10;
            _loc6_++;
         }
         UnknownVarFromRoomPicker_Sprite_1 = new Sprite();
         _container.addChild(UnknownVarFromRoomPicker_Sprite_1);
         UnknownVarFromRoomPicker_Button_1 = new ColouredButton("gfreen",_newUserFlow.getLocalization("room.select","Select"),new Rectangle(0,0,0,40),true,onButtonSelect);
         var _loc7_:Bitmap = LoaderUI.createBalloon(640,100,0,false,995918,"none");
         UnknownVarFromRoomPicker_Sprite_1.addChild(_loc7_);
         _loc7_.x = _spaceBetweenImages;
         LoaderUI.lineUpVertically(_loc3_,20,_loc7_);
         var _loc4_:Sprite = new Sprite();
         _loc4_.addChild(UnknownVarFromRoomPicker_Button_1);
         _container.addChild(_loc4_);
         _loc4_.x = 725;
         _loc4_.y = 360;
         if(!UnknownVarFromRoomPicker_TextField_1)
         {
            UnknownVarFromRoomPicker_TextField_1 = LoaderUI.createTextField(_newUserFlow.getLocalization("receptionist.start.title","Hiya!"),18,8309486,false);
            _roomName = LoaderUI.createTextField(_newUserFlow.getLocalization("onboarding.hint.hc","Room name"),20,16777215,false,true,false,false);
            _roomName.width = 260;
            _roomName.x = 50;
            UnknownVarFromRoomPicker_TextField_1.x = 50;
            UnknownVarFromRoomPicker_TextField_1.width = 260;
            LoaderUI.lineUpVertically(_loc3_,30,_roomName);
            LoaderUI.lineUpVertically(_loc3_,55,UnknownVarFromRoomPicker_TextField_1);
            UnknownVarFromRoomPicker_Sprite_1.addChild(UnknownVarFromRoomPicker_TextField_1);
            UnknownVarFromRoomPicker_Sprite_1.addChild(_roomName);
         }
         UnknownVarFromRoomPicker_Int_1 = 1;
         if(!UnknownVarFromRoomPicker_Bitmap_1)
         {
            UnknownVarFromRoomPicker_Bitmap_1 = Bitmap(new room_selected_icon_png());
            UnknownVarFromRoomPicker_Sprite_1.addChild(UnknownVarFromRoomPicker_Bitmap_1);
         }
         UnknownVarFromRoomPicker_Sprite_1.visible = UnknownVarFromRoomPicker_Int_2 == _numOfRooms;
         UnknownVarFromRoomPicker_Button_1.visible = UnknownVarFromRoomPicker_Int_2 == _numOfRooms;
         chooseRoom();
      }
      
      private function getRoomDescription() : void
      {
         var _loc1_:String = _roomTypes[UnknownVarFromRoomPicker_Int_1 - 1];
         _roomName.text = _newUserFlow.getLocalization("room.name." + _loc1_,"Room " + _loc1_);
         UnknownVarFromRoomPicker_TextField_1.text = _newUserFlow.getLocalization("room.description." + _loc1_,"\nTwo-line description");
      }
      
      private function onButtonSelect(param1:DisplayObject) : void
      {
         var _loc2_:String = _roomTypes[UnknownVarFromRoomPicker_Int_1 - 1];
         _newUserFlow.communicationManager.connection.send(new SelectInitialRoomComposer(_loc2_));
      }
      
      private function onRoomClick(param1:Event) : void
      {
         UnknownVarFromRoomPicker_Int_1 = int(param1.currentTarget.name);
         chooseRoom();
      }
      
      private function roomImageLoadCompleteHandler(param1:Event) : void
      {
         UnknownVarFromRoomPicker_Int_2++;
         if(UnknownVarFromRoomPicker_Int_2 == _numOfRooms)
         {
            initView();
         }
      }
      
      private function chooseRoom() : void
      {
         var _loc1_:Sprite = _roomImageContainers[UnknownVarFromRoomPicker_Int_1 - 1];
         if(_loc1_ == null)
         {
            return;
         }
         UnknownVarFromRoomPicker_Bitmap_1.x = _loc1_.x;
         UnknownVarFromRoomPicker_Bitmap_1.y = _loc1_.y + _loc1_.height - UnknownVarFromRoomPicker_Bitmap_1.height;
         UnknownVarFromRoomPicker_Bitmap_1.visible = true;
         UnknownVarFromRoomPicker_Button_1.visible = UnknownVarFromRoomPicker_Int_2 == _numOfRooms;
         getRoomDescription();
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _newUserFlow.communicationManager.removeHabboConnectionMessageEvent(UnknownVarFromRoomPicker_IMessageEvent_1);
         if(_container)
         {
            while(_container.numChildren > 0)
            {
               _container.removeChildAt(0);
            }
         }
         _container = null;
         _roomImages = null;
         _newUserFlow = null;
      }
      
      public function get disposed() : Boolean
      {
         return _newUserFlow == null;
      }
   }
}

