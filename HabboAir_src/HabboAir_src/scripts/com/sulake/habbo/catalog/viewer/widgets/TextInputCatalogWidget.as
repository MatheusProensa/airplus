package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;
   
   public class TextInputCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var UnknownVarFromTextInputCatalogWidget_ITextFieldWindow_1:ITextFieldWindow;
      
      public function TextInputCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         UnknownVarFromTextInputCatalogWidget_ITextFieldWindow_1 = _window.findChildByName("input_text") as ITextFieldWindow;
         if(UnknownVarFromTextInputCatalogWidget_ITextFieldWindow_1 != null)
         {
            UnknownVarFromTextInputCatalogWidget_ITextFieldWindow_1.addEventListener("WKE_KEY_UP",onKey);
         }
         return true;
      }
      
      private function onKey(param1:WindowKeyboardEvent) : void
      {
         if(UnknownVarFromTextInputCatalogWidget_ITextFieldWindow_1 == null)
         {
            return;
         }
         events.dispatchEvent(new TextInputEvent(UnknownVarFromTextInputCatalogWidget_ITextFieldWindow_1.text));
      }
   }
}

