package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class DropBaseController extends InteractiveController implements ITouchAwareWindow
   {
      protected static const CAPTION_BLEND_CHANGE:Number = 0.5;
      
      protected static const TEXT_FIELD_NAME:String = "_DROPLIST_TITLETEXT";
      
      protected static const ITEM_LIST_NAME:String = "_DROPLIST_ITEMLIST";
      
      protected static const REGION_NAME:String = "_DROPLIST_REGION";
      
      private static const SUB_WINDOW_MAX_DESKTOP_PADDING:int = 30;
      
      private var UnknownVarFromDropBaseController_Boolean_1:Boolean = false;
      
      private var UnknownVarFromDropBaseController_Boolean_2:Boolean = false;
      
      protected var _itemArray:Vector.<IWindowModel> = new Vector.<IWindowModel>();
      
      protected var _selection:int = -1;
      
      protected var _menuIsOpen:Boolean = false;
      
      protected var UnknownVarFromDropBaseController_Boolean_3:Boolean = false;
      
      protected var UnknownVarFromDropBaseController_DropBaseController_1:DropBaseController;
      
      public function DropBaseController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 1;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         getRegion().addEventListener("WME_DOWN",menuItemEventHandler);
      }
      
      public function get selection() : int
      {
         return _selection;
      }
      
      public function set selection(param1:int) : void
      {
         if(param1 > numMenuItems - 1)
         {
            throw new Error("Menu selection index out of range!");
         }
         var _loc2_:WindowEvent = WindowEvent.allocate("WE_SELECT",this,null,true);
         update(this,_loc2_);
         if(!_loc2_.isWindowOperationPrevented())
         {
            _loc2_.recycle();
            _selection = param1;
            closeExpandedMenuView();
            _loc2_ = WindowEvent.allocate("WE_SELECTED",this,null);
            update(this,_loc2_);
         }
         _loc2_.recycle();
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         var _loc2_:ILabelWindow = getTitleLabel();
         if(_loc2_)
         {
            _loc2_.text = param1;
         }
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:IRegionWindow = getRegion();
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener("WME_DOWN",menuItemEventHandler);
         }
         if(UnknownVarFromDropBaseController_DropBaseController_1 != null && !UnknownVarFromDropBaseController_DropBaseController_1.disposed)
         {
            UnknownVarFromDropBaseController_DropBaseController_1.destroy();
            UnknownVarFromDropBaseController_DropBaseController_1 = null;
         }
         for each(var _loc1_ in _itemArray)
         {
            _loc1_.dispose();
         }
         _itemArray = null;
         super.dispose();
      }
      
      override public function activate() : Boolean
      {
         if(_menuIsOpen)
         {
            return true;
         }
         return super.activate();
      }
      
      public function getTitleLabel() : ILabelWindow
      {
         return getChildByName("_DROPLIST_TITLETEXT") as ILabelWindow;
      }
      
      public function getItemList() : IItemListWindow
      {
         return getChildByName("_DROPLIST_ITEMLIST") as IItemListWindow;
      }
      
      public function getRegion() : IRegionWindow
      {
         return getChildByName("_DROPLIST_REGION") as IRegionWindow;
      }
      
      override public function populate(param1:Array) : void
      {
         var _loc2_:IWindowModel = null;
         _menuIsOpen = true;
         closeExpandedMenuView();
         _selection = -1;
         while(_itemArray.length > 0)
         {
            _loc2_ = _itemArray.pop();
            if(param1.indexOf(_loc2_) == -1)
            {
               _loc2_.dispose();
            }
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _itemArray.push(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      protected function openExpandedMenuView() : void
      {
         var _loc1_:WindowEvent = null;
         if(!_menuIsOpen)
         {
            if(open())
            {
               _loc1_ = WindowEvent.allocate("WE_EXPANDED",this,null);
               update(this,_loc1_);
               _loc1_.recycle();
               if(numMenuItems > 0)
               {
                  _menuIsOpen = true;
                  UnknownVarFromDropBaseController_Boolean_3 = true;
                  populateExpandedMenu(_itemArray,getExpandedMenuView(),subMenuEventProc);
               }
            }
         }
      }
      
      protected function closeExpandedMenuView() : void
      {
         var _loc1_:IDropListItemController = null;
         var _loc4_:IWindowModel = null;
         var _loc2_:IItemListWindow = null;
         var _loc3_:int = 0;
         var _loc6_:WindowEvent = null;
         var _loc5_:ILabelWindow = null;
         if(close())
         {
            if(UnknownVarFromDropBaseController_DropBaseController_1 != null)
            {
               _loc2_ = UnknownVarFromDropBaseController_DropBaseController_1.getItemList();
               _loc2_.autoArrangeItems = false;
               _loc3_ = 0;
               while(_loc3_ < _loc2_.numListItems)
               {
                  _loc1_ = _loc2_.getListItemAt(_loc3_) as IDropListItemController;
                  if(_loc1_)
                  {
                     _loc4_ = _loc1_.value;
                     if(_itemArray.indexOf(_loc4_) > -1)
                     {
                        _loc1_.value = null;
                        _loc4_.setParamFlag(3,false);
                     }
                  }
                  _loc3_++;
               }
               UnknownVarFromDropBaseController_DropBaseController_1.destroy();
               UnknownVarFromDropBaseController_DropBaseController_1 = null;
            }
            if(_menuIsOpen)
            {
               _loc6_ = WindowEvent.allocate("WE_COLLAPSE",this,null);
               update(this,_loc6_);
               _loc6_.recycle();
            }
            _menuIsOpen = false;
            if(!disposed)
            {
               _loc5_ = getTitleLabel();
               _loc2_ = getItemList();
               if(_loc2_)
               {
                  while(_loc2_.numListItems > 0)
                  {
                     _loc2_.removeListItemAt(0);
                  }
                  if(_selection < numMenuItems && _selection > -1)
                  {
                     _loc4_ = _itemArray[_selection];
                     _loc4_.x = 0;
                     _loc4_.y = 0;
                     _loc2_.addListItem(_loc4_);
                     _loc2_.height = _loc4_.height;
                     _loc5_.visible = false;
                  }
                  else
                  {
                     _loc5_.visible = true;
                  }
               }
            }
         }
      }
      
      private function getExpandedMenuView() : DropBaseController
      {
         var _loc1_:Rectangle = new Rectangle();
         getGlobalRectangle(_loc1_);
         if(UnknownVarFromDropBaseController_DropBaseController_1 == null || UnknownVarFromDropBaseController_DropBaseController_1.disposed)
         {
            UnknownVarFromDropBaseController_DropBaseController_1 = context.create(name + "::subMenu","",type,_style,131072 | (uint(UnknownVarFromDropBaseController_Boolean_1 ? 1048576 : 0)) | 0,_loc1_,subMenuEventProc,null,0,null,"",["_EXCLUDE"]) as DropBaseController;
         }
         else
         {
            UnknownVarFromDropBaseController_DropBaseController_1.setGlobalRectangle(_loc1_);
         }
         UnknownVarFromDropBaseController_DropBaseController_1.activate();
         return UnknownVarFromDropBaseController_DropBaseController_1;
      }
      
      protected function populateExpandedMenu(param1:Vector.<IWindowModel>, param2:DropBaseController, param3:Function) : void
      {
         var _loc5_:IDropListItemController = null;
         var _loc12_:IWindowModel = null;
         var _loc7_:IItemListWindow = param2.getItemList();
         _loc7_.autoArrangeItems = false;
         param2.getRegion().visible = false;
         var _loc10_:uint = param1.length;
         var _loc9_:int;
         var _loc6_:* = _loc9_ = int(_loc7_.width);
         var _loc8_:int = 0;
         var _loc11_:uint = 0;
         while(_loc11_ < _loc10_)
         {
            _loc12_ = param1[_loc11_];
            _loc5_ = context.create(name + "::menuItem[" + _loc11_ + "]",_loc12_.caption,106,_style,0 | 0 | 0x10 | 1 | 0,null,param3,null,_loc11_,null,"",["_EXCLUDE"]) as DropListItemController;
            _loc12_.x = 0;
            _loc12_.y = 0;
            _loc12_.setParamFlag(3,true);
            _loc5_.value = _loc12_;
            _loc5_.width = _loc5_.value.width;
            _loc5_.height = _loc5_.value.height;
            _loc5_.limits.minWidth = _loc9_;
            _loc6_ = Math.max(_loc6_,_loc5_.width);
            _loc8_ += _loc5_.height;
            _loc7_.addListItem(_loc5_);
            _loc11_++;
         }
         if(_loc6_ > _loc9_)
         {
            param2.width += _loc6_ - _loc7_.width;
            _loc11_ = 0;
            while(_loc11_ < _loc10_)
            {
               _loc7_.getListItemAt(_loc11_).limits.minWidth = _loc6_;
               _loc11_++;
            }
         }
         var _loc4_:IWindowModel = context.create(name + "::padding","",4,_style,0 | 0 | 0x10 | 0,new Rectangle(0,0,1,3),null,null,0,null,"",["_EXCLUDE"]);
         _loc7_.addListItem(_loc4_);
         _loc7_.autoArrangeItems = true;
         _loc8_ += _loc4_.height;
         _loc8_ = _loc8_ + _loc7_.spacing * _loc7_.numListItems;
         param2.height = Math.max(param2.height,_loc8_ + 4);
         if(param & 0x20)
         {
            fitToParent(param2);
         }
         else
         {
            fitToDesktop(param2);
         }
         param2.activate();
         _loc7_.height = Math.max(_loc7_.height,param2.height - 4);
         if(_selection > -1 && _loc10_)
         {
            _loc7_.getListItemAt(_selection).setStateFlag(8,true);
         }
      }
      
      protected function fitToParent(param1:IWindowModel) : void
      {
         var _loc2_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc2_);
         var _loc3_:Rectangle = new Rectangle();
         parent.getGlobalRectangle(_loc3_);
         if(_loc2_.height > _loc3_.height)
         {
            param1.offset(0,_loc3_.top - _loc2_.top);
            param1.scale(0,_loc3_.height - _loc2_.height);
            param1.getGlobalRectangle(_loc2_);
         }
         if(_loc2_.bottom > _loc3_.bottom)
         {
            param1.offset(0,_loc3_.bottom - _loc2_.bottom);
         }
         else if(_loc2_.top < _loc3_.top)
         {
            param1.offset(0,_loc2_.top - _loc3_.top);
         }
         if(_loc2_.left < _loc3_.left)
         {
            param1.offset(_loc2_.left - _loc3_.left,0);
         }
         else if(_loc2_.right > _loc3_.right)
         {
            param1.offset(_loc3_.right - _loc2_.right,0);
         }
      }
      
      protected function fitToDesktop(param1:IWindowModel) : void
      {
         var _loc2_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc2_);
         if(_loc2_.bottom > desktop.bottom)
         {
            param1.offset(0,desktop.bottom - _loc2_.bottom);
         }
         else if(_loc2_.top < desktop.top)
         {
            param1.offset(0,_loc2_.top - desktop.top);
         }
         if(_loc2_.left < desktop.left)
         {
            param1.offset(_loc2_.left - desktop.left,0);
         }
         else if(_loc2_.right > desktop.right)
         {
            param1.offset(desktop.right - _loc2_.right,0);
         }
         if(_loc2_.height > desktop.height - 30)
         {
            param1.height = desktop.height - 30;
            param1.y = 30;
         }
      }
      
      private function menuItemEventHandler(param1:WindowEvent) : void
      {
         if(getStateFlag(32))
         {
            return;
         }
         if(param1.type == "WME_DOWN" || param1.type == "WTE_TAP")
         {
            if(!_menuIsOpen)
            {
               openExpandedMenuView();
            }
         }
      }
      
      protected function subMenuEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         switch(param1.type)
         {
            case "WTE_END":
            case "WME_UP":
               if(param2 is IDropListItemController)
               {
                  if(!UnknownVarFromDropBaseController_Boolean_3)
                  {
                     selection = resolveSelection(param2);
                  }
                  UnknownVarFromDropBaseController_Boolean_3 = false;
               }
               break;
            case "WTE_BEGIN":
            case "WME_DOWN":
               selection = resolveSelection(param2);
               break;
            case "WE_DEACTIVATED":
               if(param2 == UnknownVarFromDropBaseController_DropBaseController_1)
               {
                  if(!(UnknownVarFromDropBaseController_Boolean_2 && _menuIsOpen))
                  {
                     closeExpandedMenuView();
                  }
                  break;
               }
         }
      }
      
      protected function resolveSelection(param1:IWindowModel) : int
      {
         var _loc2_:int = int(_itemArray.indexOf(param1));
         if(_loc2_ == -1)
         {
            if(param1 is IDropListItemController)
            {
               _loc2_ = int(_itemArray.indexOf(IDropListItemController(param1).value));
            }
         }
         if(_loc2_ == -1)
         {
            return _selection;
         }
         return _loc2_;
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         switch(param2.type)
         {
            case "WTE_BEGIN":
            case "WME_DOWN":
               if(_menuIsOpen)
               {
                  if(UnknownVarFromDropBaseController_Boolean_2)
                  {
                     closeExpandedMenuView();
                  }
               }
               else
               {
                  openExpandedMenuView();
               }
               break;
            case "WE_ENABLED":
               try
               {
                  getChildByName("_DROPLIST_REGION").visible = true;
                  getChildByName("_DROPLIST_TITLETEXT").blend = getChildByName("_DROPLIST_TITLETEXT").blend + 0.5;
               }
               catch(e:Error)
               {
               }
               break;
            case "WE_DISABLED":
               try
               {
                  getChildByName("_DROPLIST_REGION").visible = false;
                  getChildByName("_DROPLIST_TITLETEXT").blend = getChildByName("_DROPLIST_TITLETEXT").blend - 0.5;
               }
               catch(e:Error)
               {
               }
         }
         return super.update(param1,param2);
      }
      
      public function open() : Boolean
      {
         if(getStateFlag(0))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_OPEN",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         visible = true;
         _loc1_ = WindowEvent.allocate("WE_OPENED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function close() : Boolean
      {
         if(!getStateFlag(0))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_CLOSE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         visible = false;
         _loc1_ = WindowEvent.allocate("WE_CLOSED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function get numMenuItems() : int
      {
         return _itemArray.length;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("open_upward",UnknownVarFromDropBaseController_Boolean_1));
         _loc1_.push(createProperty("keep_open_on_deactivate",UnknownVarFromDropBaseController_Boolean_2));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "open_upward":
                  UnknownVarFromDropBaseController_Boolean_1 = Boolean(_loc2_.value);
                  break;
               case "keep_open_on_deactivate":
                  UnknownVarFromDropBaseController_Boolean_2 = Boolean(_loc2_.value);
                  break;
            }
         }
         super.properties = param1;
      }
   }
}

