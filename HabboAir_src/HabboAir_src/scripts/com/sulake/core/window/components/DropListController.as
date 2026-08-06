package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.iterators.DropListIterator;
   import com.sulake.core.window.utils.IIterable;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class DropListController extends DropBaseController implements IDropBaseController_2, IIterable, ITouchAwareWindow
   {
      public function DropListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get iterator() : IIterator
      {
         return new DropListIterator(this);
      }
      
      public function addMenuItem(param1:IWindowModel) : IWindowModel
      {
         return addMenuItemAt(param1,_itemArray.length);
      }
      
      public function addMenuItemAt(param1:IWindowModel, param2:int) : IWindowModel
      {
         if(param1 && _itemArray.indexOf(param1) == -1)
         {
            if(!getTitleLabel())
            {
               if(param1 is ILabelWindow)
               {
                  if(param1.name == "_DROPLIST_TITLETEXT")
                  {
                     return addChild(param1);
                  }
               }
            }
            if(!getItemList())
            {
               if(param1 is IItemListWindow)
               {
                  if(param1.name == "_DROPLIST_ITEMLIST")
                  {
                     return addChild(param1);
                  }
               }
            }
            if(!getRegion())
            {
               if(param1 is IRegionWindow)
               {
                  if(param1.name == "_DROPLIST_REGION")
                  {
                     return addChild(param1);
                  }
               }
            }
            if(_menuIsOpen)
            {
               closeExpandedMenuView();
               _itemArray.push(param1);
               openExpandedMenuView();
            }
            else
            {
               _itemArray.push(param1);
            }
            return param1;
         }
         return null;
      }
      
      public function getMenuItemAt(param1:int) : IWindowModel
      {
         return _itemArray != null && param1 > -1 && param1 < _itemArray.length ? _itemArray[param1] : null;
      }
      
      public function removeMenuItem(param1:IWindowModel) : IWindowModel
      {
         var _loc2_:int = int(_itemArray.indexOf(param1));
         if(_loc2_ > -1)
         {
            if(_loc2_ == _selection)
            {
               _selection = -1;
            }
            _itemArray.splice(_loc2_,1);
            if(_menuIsOpen)
            {
               closeExpandedMenuView();
               openExpandedMenuView();
            }
            return param1;
         }
         return null;
      }
      
      public function removeMenuItemAt(param1:int) : IWindowModel
      {
         var _loc2_:IWindowModel = _itemArray[param1];
         return !!_loc2_ ? removeMenuItem(_loc2_) : null;
      }
      
      public function getMenuItemIndex(param1:IWindowModel) : int
      {
         return _itemArray.indexOf(param1);
      }
   }
}

