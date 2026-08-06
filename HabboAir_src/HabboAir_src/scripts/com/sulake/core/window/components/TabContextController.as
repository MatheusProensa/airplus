package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterable;
   import com.sulake.core.window.utils.IIterator;
   import flash.geom.Rectangle;
   
   public class TabContextController extends WindowController implements ITabContextWindow, IIterable
   {
      private static const TAG_TAB_CONTEXT_SELECTOR:String = "_SELECTOR";
      
      private static const TAG_TAB_CONTEXT_CONTENT:String = "_CONTENT";
      
      protected var UnknownVarFromTabContextController_ISelectorListWindow_1:ISelectorListWindow;
      
      protected var UnknownVarFromTabContextController_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromTabContextController_Boolean_1:Boolean = false;
      
      private var UnknownVarFromTabContextController_Boolean_2:Boolean = false;
      
      public function TabContextController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var _loc12_:Array = [];
         groupChildrenWithTag("_INTERNAL",_loc12_,-1);
         for each(var _loc13_ in _loc12_)
         {
            _loc13_.style = _style;
            _loc13_.procedure = selectorEventProc;
         }
         UnknownVarFromTabContextController_Boolean_2 = true;
      }
      
      public function get selector() : ISelectorListWindow
      {
         if(UnknownVarFromTabContextController_ISelectorListWindow_1 == null)
         {
            UnknownVarFromTabContextController_ISelectorListWindow_1 = findChildByTag("_SELECTOR") as ISelectorListWindow;
            if(UnknownVarFromTabContextController_ISelectorListWindow_1 != null)
            {
               UnknownVarFromTabContextController_ISelectorListWindow_1.procedure = selectorEventProc;
            }
         }
         return UnknownVarFromTabContextController_ISelectorListWindow_1;
      }
      
      public function get container() : IWindowController_1
      {
         if(UnknownVarFromTabContextController_IWindowController_1_1 == null)
         {
            UnknownVarFromTabContextController_IWindowController_1_1 = findChildByTag("_CONTENT") as IWindowController_1;
         }
         return UnknownVarFromTabContextController_IWindowController_1_1;
      }
      
      public function get iterator() : IIterator
      {
         return UnknownVarFromTabContextController_Boolean_2 ? selector.iterator : null;
      }
      
      public function get numTabItems() : uint
      {
         return UnknownVarFromTabContextController_ISelectorListWindow_1.numSelectables;
      }
      
      public function addTabItem(param1:ITabButtonWindow) : ITabButtonWindow
      {
         return selector.addSelectable(param1) as ITabButtonWindow;
      }
      
      public function addTabItemAt(param1:ITabButtonWindow, param2:uint) : ITabButtonWindow
      {
         return selector.addSelectableAt(param1,param2) as ITabButtonWindow;
      }
      
      public function removeTabItem(param1:ITabButtonWindow) : void
      {
         selector.removeSelectable(param1);
      }
      
      public function getTabItemAt(param1:uint) : ITabButtonWindow
      {
         return selector.getSelectableAt(param1) as ITabButtonWindow;
      }
      
      public function getTabItemByName(param1:String) : ITabButtonWindow
      {
         return selector.getSelectableByName(param1) as ITabButtonWindow;
      }
      
      public function getTabItemByID(param1:uint) : ITabButtonWindow
      {
         return selector.getSelectableByID(param1) as ITabButtonWindow;
      }
      
      public function getTabItemIndex(param1:ITabButtonWindow) : uint
      {
         return selector.getSelectableIndex(param1);
      }
      
      private function selectorEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WE_SELECTED")
         {
            notifyEventListeners(param1);
         }
      }
   }
}

