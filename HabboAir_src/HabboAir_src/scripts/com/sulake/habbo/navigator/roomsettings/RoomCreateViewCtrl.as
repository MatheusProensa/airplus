package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CreateFlatMessageComposer;
   import com.sulake.habbo.navigator.*;
   import com.sulake.habbo.navigator.domain.RoomLayout;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class RoomCreateViewCtrl
   {
      private static const ROOM_LIMIT_HC:int = 75;
      
      private static const ROOM_LIMIT_NON_SUBSCRIBER:int = 50;
      
      private var _navigator:IHabboNavigator_2;
      
      private var _content:IWindowController_1;
      
      private var UnknownVarFromRoomCreateViewCtrl_IItemListWindow_1:IItemListWindow;
      
      private var _layouts:Vector.<RoomLayout>;
      
      private var _selectedLayout:RoomLayout;
      
      private var UnknownVarFromRoomCreateViewCtrl_Timer_1:Timer;
      
      private var UnknownVarFromRoomCreateViewCtrl_Boolean_1:Boolean = true;
      
      private var UnknownVarFromRoomCreateViewCtrl_TextFieldManager_1:TextFieldManager;
      
      private var UnknownVarFromRoomCreateViewCtrl_TextFieldManager_2:TextFieldManager;
      
      private var UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_1:IDropBaseController_1;
      
      private var _maxVisitors:IDropBaseController_1;
      
      private var UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_2:IDropBaseController_1;
      
      private var _selectableAndVisibleCategories:Array = [];
      
      public function RoomCreateViewCtrl(param1:IHabboNavigator_2)
      {
         super();
         _navigator = param1;
         UnknownVarFromRoomCreateViewCtrl_Timer_1 = new Timer(100);
         UnknownVarFromRoomCreateViewCtrl_Timer_1.addEventListener("timer",updateArrowPos);
         _layouts = new Vector.<RoomLayout>();
         _layouts.push(new RoomLayout(0,104,"a"));
         _layouts.push(new RoomLayout(0,94,"b"));
         _layouts.push(new RoomLayout(0,36,"c"));
         _layouts.push(new RoomLayout(0,84,"d"));
         _layouts.push(new RoomLayout(0,80,"e"));
         _layouts.push(new RoomLayout(0,80,"f"));
         _layouts.push(new RoomLayout(0,416,"i"));
         _layouts.push(new RoomLayout(0,320,"j"));
         _layouts.push(new RoomLayout(0,448,"k"));
         _layouts.push(new RoomLayout(0,352,"l"));
         _layouts.push(new RoomLayout(0,384,"m"));
         _layouts.push(new RoomLayout(0,372,"n"));
         _layouts.push(new RoomLayout(1,80,"g"));
         _layouts.push(new RoomLayout(1,74,"h"));
         _layouts.push(new RoomLayout(1,416,"o"));
         _layouts.push(new RoomLayout(1,352,"p"));
         _layouts.push(new RoomLayout(1,304,"q"));
         _layouts.push(new RoomLayout(1,336,"r"));
         _layouts.push(new RoomLayout(1,748,"u"));
         _layouts.push(new RoomLayout(1,438,"v"));
         _layouts.push(new RoomLayout(2,540,"t"));
         _layouts.push(new RoomLayout(2,512,"w"));
         _layouts.push(new RoomLayout(2,396,"x"));
         _layouts.push(new RoomLayout(2,440,"y"));
         _layouts.push(new RoomLayout(2,456,"z"));
         _layouts.push(new RoomLayout(2,208,"0"));
         _layouts.push(new RoomLayout(2,1009,"1"));
         _layouts.push(new RoomLayout(2,1044,"2"));
         _layouts.push(new RoomLayout(2,183,"3"));
         _layouts.push(new RoomLayout(2,254,"4"));
         _layouts.push(new RoomLayout(2,1024,"5"));
         _layouts.push(new RoomLayout(2,801,"6"));
         _layouts.push(new RoomLayout(2,354,"7"));
         _layouts.push(new RoomLayout(2,888,"8"));
         _layouts.push(new RoomLayout(2,926,"9"));
         _layouts.push(new RoomLayout(-1,2500,"snowwar1"));
         _layouts.push(new RoomLayout(-1,2500,"snowwar2"));
      }
      
      private static function addMouseClickListener(param1:IWindowModel, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.setParamFlag(1,true);
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromRoomCreateViewCtrl_Timer_1)
         {
            UnknownVarFromRoomCreateViewCtrl_Timer_1.removeEventListener("timer",updateArrowPos);
            UnknownVarFromRoomCreateViewCtrl_Timer_1.reset();
            UnknownVarFromRoomCreateViewCtrl_Timer_1 = null;
         }
      }
      
      private function updateArrowPos(param1:Event) : void
      {
         var _loc5_:String = "select_arrow";
         var _loc3_:IBitmapWrapperController = IBitmapWrapperController(_selectedLayout.view.findChildByName(_loc5_));
         var _loc2_:int = 0;
         var _loc6_:int = 15;
         var _loc4_:int = Math.abs(_loc3_.y - _loc2_) < 2 || Math.abs(_loc3_.y - _loc6_) < 2 ? 1 : 2;
         _loc3_.y += UnknownVarFromRoomCreateViewCtrl_Boolean_1 ? _loc4_ : -_loc4_;
         if(_loc3_.y < _loc2_)
         {
            UnknownVarFromRoomCreateViewCtrl_Boolean_1 = true;
            _loc3_.y = _loc2_ + 1;
         }
         else if(_loc3_.y > _loc6_)
         {
            UnknownVarFromRoomCreateViewCtrl_Boolean_1 = false;
            _loc3_.y = _loc6_ - 1;
         }
      }
      
      public function hide() : void
      {
         if(_content)
         {
            _content.visible = false;
         }
      }
      
      public function show() : void
      {
         this.prepare();
         this._content.visible = true;
         this.refresh();
         this._content.activate();
         this.UnknownVarFromRoomCreateViewCtrl_Timer_1.start();
      }
      
      private function prepare() : void
      {
         if(this._content != null)
         {
            return;
         }
         _content = IWindowController_1(_navigator.getXmlWindow("roc_create_room"));
         UnknownVarFromRoomCreateViewCtrl_IItemListWindow_1 = IItemListWindow(_content.findChildByName("layout_item_list"));
         refreshRoomThumbnails();
         var _loc4_:UnknownICoreWindowComponents4 = getCreateButton();
         addMouseClickListener(_loc4_,onCreateButtonClick);
         var _loc1_:UnknownICoreWindowComponents4 = getCancelButton();
         addMouseClickListener(_loc1_,onCancelButtonClick);
         var _loc3_:IWindowModel = _content.findChildByTag("close");
         addMouseClickListener(_loc3_,onCancelButtonClick);
         UnknownVarFromRoomCreateViewCtrl_TextFieldManager_1 = new TextFieldManager(_navigator,ITextFieldWindow(_content.findChildByName("room_name_input")),25,null,_navigator.getText("navigator.createroom.roomnameinfo"));
         UnknownVarFromRoomCreateViewCtrl_TextFieldManager_2 = new TextFieldManager(_navigator,ITextFieldWindow(_content.findChildByName("room_desc_input")),128,null,_navigator.getText("navigator.createroom.roomdescinfo"));
         prepareCategorySelection();
         prepareTradeModeSelection();
         refreshMaxVisitors(50);
         var _loc2_:Rectangle = Util.getLocationRelativeTo(_content.desktop,_content.width,_content.height);
         _content.x = _loc2_.x;
         _content.y = _loc2_.y;
      }
      
      private function prepareCategorySelection() : void
      {
         UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_1 = _content.findChildByName("categories_list") as IDropBaseController_1;
         var _loc1_:Array = [];
         _selectableAndVisibleCategories = [];
         for each(var _loc2_ in _navigator.data.visibleCategories)
         {
            if(!_loc2_.automatic && (!_loc2_.staffOnly || _loc2_.staffOnly && _navigator.sessionData.hasSecurity(7)))
            {
               _selectableAndVisibleCategories.push(_loc2_);
               _loc1_.push(_loc2_.visibleName);
            }
         }
         UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_1.populate(_loc1_);
         UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_1.selection = 0;
      }
      
      private function prepareTradeModeSelection() : void
      {
         UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_2 = _content.findChildByName("trade_settings_list") as IDropBaseController_1;
         var _loc1_:Array = [];
         _loc1_.push("${navigator.roomsettings.trade_not_allowed}");
         _loc1_.push("${navigator.roomsettings.trade_not_with_Controller}");
         _loc1_.push("${navigator.roomsettings.trade_allowed}");
         UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_2.populate(_loc1_);
         UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_2.selection = 0;
      }
      
      public function refresh() : void
      {
         UnknownVarFromRoomCreateViewCtrl_TextFieldManager_1.goBackToInitialState();
         UnknownVarFromRoomCreateViewCtrl_TextFieldManager_1.input.textBackgroundColor = 4294967295;
         UnknownVarFromRoomCreateViewCtrl_TextFieldManager_2.goBackToInitialState();
         UnknownVarFromRoomCreateViewCtrl_TextFieldManager_2.input.textBackgroundColor = 4294967295;
         UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_2.selection = 0;
         UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_1.selection = 0;
         _selectedLayout = _layouts[0];
         this.refreshRoomThumbnails();
         if(_navigator.sessionData.hasVip)
         {
            refreshMaxVisitors(75);
         }
         else
         {
            refreshMaxVisitors(50);
         }
         refreshSelection();
      }
      
      private function refreshMaxVisitors(param1:int) : void
      {
         var _loc2_:int = 0;
         _maxVisitors = _content.findChildByName("visitors_list") as IDropBaseController_1;
         var _loc3_:Array = [];
         _loc2_ = 10;
         while(_loc2_ <= param1)
         {
            _loc3_.push("" + _loc2_);
            _loc2_ += 5;
         }
         _maxVisitors.populate(_loc3_);
         _maxVisitors.selection = 0;
      }
      
      private function refreshSelection() : void
      {
         var _loc2_:* = false;
         var _loc3_:ITextWindow = null;
         for each(var _loc1_ in _layouts)
         {
            if(_loc1_.view != null)
            {
               _loc2_ = _loc1_ == _selectedLayout;
               _loc1_.view.findChildByName("bg_sel").visible = _loc2_;
               _loc1_.view.findChildByName("bg_unsel").visible = !_loc2_;
               _loc3_ = ITextWindow(_loc1_.view.findChildByName("tile_size_txt"));
               _loc3_.textColor = _loc2_ ? 4294967295 : 4278190080;
               _loc3_.color = _loc2_ ? 4285432196 : 4291546059;
               _navigator.refreshButton(_loc1_.view,"tile_icon_black",!_loc2_,null,0);
               _navigator.refreshButton(_loc1_.view,"tile_icon_white",_loc2_,null,0);
               _navigator.refreshButton(_loc1_.view,"select_arrow",_loc2_,null,0);
            }
         }
      }
      
      private function refreshRoomThumbnails() : void
      {
         var _loc9_:IWindowModel = null;
         var _loc6_:IWindowController_1 = null;
         var _loc5_:int = 0;
         var _loc1_:RoomLayout = null;
         var _loc2_:IWindowController_1 = null;
         var _loc4_:IWindowModel = null;
         while(UnknownVarFromRoomCreateViewCtrl_IItemListWindow_1.numListItems > 0)
         {
            _loc9_ = UnknownVarFromRoomCreateViewCtrl_IItemListWindow_1.removeListItemAt(0);
            _loc9_.destroy();
         }
         for each(var _loc7_ in _layouts)
         {
            if(_loc7_.view != null)
            {
               _loc7_.view.destroy();
               _loc7_.view = null;
            }
         }
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _layouts.length)
         {
            _loc1_ = _layouts[_loc5_];
            if(isAllowed(_loc1_,false))
            {
               if(_loc3_ == 0)
               {
                  _loc6_ = getRow();
                  UnknownVarFromRoomCreateViewCtrl_IItemListWindow_1.addListItem(_loc6_);
               }
               addThumbnail(_loc6_,_layouts[_loc5_],_loc3_ % 2 == 0);
               _loc3_ = _loc3_ == 0 ? 1 : 0;
            }
            _loc5_++;
         }
         refreshSelection();
         var _loc8_:String = null;
         if(_navigator.sessionData.clubLevel < 2 && !_navigator.getBoolean("habbo_club_buy_disabled"))
         {
            _loc8_ = "roc_vip_promo";
         }
         if(_loc8_ != null)
         {
            _loc2_ = IWindowController_1(_navigator.getXmlWindow(_loc8_));
            if(_loc2_)
            {
               _loc4_ = _loc2_.findChildByName("link");
               addMouseClickListener(_loc4_,onHcMoreClick);
               UnknownVarFromRoomCreateViewCtrl_IItemListWindow_1.addListItem(_loc2_);
            }
         }
      }
      
      private function addThumbnail(param1:IWindowController_1, param2:RoomLayout, param3:Boolean) : void
      {
         var _loc5_:IWindowController_1 = IWindowController_1(_navigator.getXmlWindow("roc_room_thumbnail"));
         _loc5_.tags.push(param2.name);
         if(!param3)
         {
            _loc5_.x = _loc5_.width;
         }
         addMouseClickListener(_loc5_,onContPicClick);
         var _loc4_:IStaticBitmapWrapperWindow = _loc5_.findChildByName("bg_pic") as IStaticBitmapWrapperWindow;
         _loc4_.assetUri = "${image.library.url}newroom/model_" + param2.name + ".png";
         param1.addChild(_loc5_);
         _navigator.sessionData.clubLevel >= 2;
         param1.width = 2 * _loc5_.width;
         param1.height = _loc5_.height;
         param2.view = _loc5_;
         ITextWindow(param2.view.findChildByName("tile_size_txt")).text = param2.tileSize + " " + _navigator.getText("navigator.createroom.tilesize");
         _loc5_.findChildByName("club_icon").visible = param2.requiredClubLevel == 1 || param2.requiredClubLevel == 2;
      }
      
      private function isAllowed(param1:RoomLayout, param2:Boolean = true) : Boolean
      {
         switch(param1.requiredClubLevel)
         {
            case 0:
               return true;
            case 1:
               return !param2 || _navigator.sessionData.hasClub;
            case 2:
               return !param2 || _navigator.sessionData.hasVip;
            default:
               return _navigator.sessionData.hasSecurity(4);
         }
      }
      
      private function getRow() : IWindowController_1
      {
         return IWindowController_1(_navigator.windowManager.createWindow("","",4,0,16,new Rectangle(0,0,100,300)));
      }
      
      private function isMandatoryFieldsFilled() : Boolean
      {
         return UnknownVarFromRoomCreateViewCtrl_TextFieldManager_1.checkMandatory(_navigator.getText("navigator.createroom.nameerr"));
      }
      
      private function getCreateButton() : UnknownICoreWindowComponents4
      {
         return UnknownICoreWindowComponents4(_content.findChildByName("create_button"));
      }
      
      private function getCancelButton() : UnknownICoreWindowComponents4
      {
         return UnknownICoreWindowComponents4(_content.findChildByName("back_button"));
      }
      
      private function onChooseLayout(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:RoomLayout = getLayout(param2);
         if(isAllowed(_loc3_,true))
         {
            _selectedLayout = _loc3_;
            refreshSelection();
         }
         else
         {
            _navigator.openCatalogClubPage("RoomCreateViewCtrl");
         }
      }
      
      private function getLayout(param1:IWindowModel) : RoomLayout
      {
         return findLayout(param1.tags[0]);
      }
      
      private function findLayout(param1:String) : RoomLayout
      {
         for each(var _loc2_ in _layouts)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return _layouts[0];
      }
      
      private function onContPicClick(param1:WindowEvent) : void
      {
         var _loc2_:IWindowController_1 = param1.target as IWindowController_1;
         onChooseLayout(param1,_loc2_);
      }
      
      private function onCancelButtonClick(param1:WindowEvent) : void
      {
         close();
      }
      
      private function onHcMoreClick(param1:WindowEvent) : void
      {
         Logger.log("HC LINK CLICKED");
         _navigator.openCatalogClubPage("RoomCreateViewCtrl");
      }
      
      private function onCreateButtonClick(param1:WindowEvent) : void
      {
         var _loc8_:String = UnknownVarFromRoomCreateViewCtrl_TextFieldManager_1.getText();
         var _loc3_:String = UnknownVarFromRoomCreateViewCtrl_TextFieldManager_2.getText();
         var _loc5_:String = "model_" + _selectedLayout.name;
         var _loc2_:int = parseInt(_maxVisitors.enumerateSelection()[_maxVisitors.selection]);
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         for each(var _loc7_ in _selectableAndVisibleCategories)
         {
            if(UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_1.selection == _loc4_)
            {
               _loc9_ = _loc7_.nodeId;
               break;
            }
            _loc4_++;
         }
         var _loc6_:int = UnknownVarFromRoomCreateViewCtrl_IDropBaseController_1_2.selection;
         if(!isMandatoryFieldsFilled())
         {
            return;
         }
         _navigator.send(new CreateFlatMessageComposer(_loc8_,_loc3_,_loc5_,_loc9_,_loc2_,_loc6_));
      }
      
      private function close() : void
      {
         this._content.visible = false;
         this.UnknownVarFromRoomCreateViewCtrl_Timer_1.reset();
      }
   }
}

