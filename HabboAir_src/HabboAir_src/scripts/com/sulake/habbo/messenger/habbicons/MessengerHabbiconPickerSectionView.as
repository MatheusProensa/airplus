package com.sulake.habbo.messenger.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class MessengerHabbiconPickerSectionView implements IComponentInterfaceQueue
   {
      private static const GRID_COLUMNS:int = 5;
      
      private static const SLOT_SIZE:int = 45;
      
      private static const SLOT_SPACING:int = 2;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMessengerHabbiconPickerSectionView_Vector_1:Vector.<MessengerHabbiconPickerTileView>;
      
      private var _type:String;
      
      private var _key:String;
      
      private var _disposed:Boolean;
      
      public function MessengerHabbiconPickerSectionView(param1:IWindowController_1, param2:String, param3:String, param4:String, param5:Array, param6:Function, param7:IHabboWindowManagerComponent, param8:Function, param9:Function)
      {
         var _loc15_:IWindowController_1 = null;
         var _loc14_:MessengerHabbiconPickerEntry = null;
         var _loc12_:MessengerHabbiconPickerTileView = null;
         var _loc10_:int = 0;
         var _loc13_:int = 0;
         var _loc16_:int = 0;
         var _loc11_:int = 0;
         super();
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromMessengerHabbiconPickerSectionView_Vector_1 = new Vector.<MessengerHabbiconPickerTileView>(0);
         _type = param2;
         _key = param3;
         sectionTitle.caption = param4;
         _loc15_ = habbiconGrid.getGridItemAt(0) as IWindowController_1;
         habbiconGrid.removeGridItems();
         _loc10_ = int(param5.length);
         _loc13_ = Math.max(1,Math.ceil(_loc10_ / 5));
         _loc16_ = _loc13_ * 5;
         _loc11_ = 0;
         while(_loc11_ < _loc16_)
         {
            _loc14_ = _loc11_ < _loc10_ ? param5[_loc11_] : null;
            _loc12_ = new MessengerHabbiconPickerTileView(_loc15_,_loc14_,param6,param7,param8,param9);
            UnknownVarFromMessengerHabbiconPickerSectionView_Vector_1.push(_loc12_);
            habbiconGrid.addGridItem(_loc12_.window);
            _loc11_++;
         }
         habbiconGrid.height = _loc13_ * 45 + (_loc13_ - 1) * 2;
         _window.height = 20 + habbiconGrid.height + 2;
         _loc15_.dispose();
         _window.visible = true;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function clearUnseenCounterForHabbicon(param1:int) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in UnknownVarFromMessengerHabbiconPickerSectionView_Vector_1)
         {
            _loc2_.clearUnseenCounterForHabbicon(param1);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         for each(_loc1_ in UnknownVarFromMessengerHabbiconPickerSectionView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromMessengerHabbiconPickerSectionView_Vector_1.length = 0;
         if(_window != null)
         {
            if(_window.parent != null)
            {
               IWindowController_1(_window.parent).removeChild(_window);
            }
            _window.dispose();
            _window = null;
         }
         UnknownVarFromMessengerHabbiconPickerSectionView_Vector_1 = null;
         _type = null;
         _key = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get sectionTitle() : ITextWindow
      {
         return _window.findChildByName("section_title") as ITextWindow;
      }
      
      private function get habbiconGrid() : IItemGridWindow
      {
         return _window.findChildByName("habbicon_grid") as IItemGridWindow;
      }
   }
}

