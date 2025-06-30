import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Badge } from '@/components/ui/badge';
import { Switch } from '@/components/ui/switch';
import FormFieldsPanel from './FormFieldsPanel';
import FormPreview from './FormPreview';
import FormDataPreview from './FormDataPreview';
import JSPExporter from './JSPExporter';
import { Plus, Eye, Code2, Download } from 'lucide-react';
import { toast } from '@/hooks/use-toast';

export interface FormField {
  id: string;
  type: 'text' | 'email' | 'number' | 'password' | 'textarea' | 'select' | 'checkbox' | 'radio' | 'date' | 'file';
  label: string;
  name: string;
  placeholder?: string;
  required: boolean;
  options?: string[];
  validation?: {
    min?: number;
    max?: number;
    pattern?: string;
    message?: string;
  };
}

const FormBuilder = () => {
  const [formFields, setFormFields] = useState<FormField[]>([]);
  const [formData, setFormData] = useState<Record<string, any>>({});
  const [formName, setFormName] = useState('MyForm');
  const [activeTab, setActiveTab] = useState('builder');

  const addField = (field: Omit<FormField, 'id'>) => {
    const newField: FormField = {
      ...field,
      id: `field_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
    };
    setFormFields([...formFields, newField]);
    toast({
      title: "Field Added",
      description: `${field.label} field has been added to your form.`,
    });
  };

  const removeField = (id: string) => {
    setFormFields(formFields.filter(field => field.id !== id));
    const newFormData = { ...formData };
    delete newFormData[id];
    setFormData(newFormData);
    toast({
      title: "Field Removed",
      description: "Field has been removed from your form.",
    });
  };

  const updateField = (id: string, updates: Partial<FormField>) => {
    setFormFields(formFields.map(field => 
      field.id === id ? { ...field, ...updates } : field
    ));
  };

  const handleFormDataChange = (fieldId: string, value: any) => {
    setFormData({ ...formData, [fieldId]: value });
  };

  useEffect(() => {
    console.log('Form data updated:', formData);
  }, [formData]);

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <div className="lg:col-span-2">
        <Card className="shadow-xl border-0 bg-white/80 backdrop-blur-sm">
          <CardHeader className="bg-gradient-to-r from-purple-600 to-blue-600 text-white rounded-t-lg">
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-2xl">Form Builder</CardTitle>
                <div className="flex items-center space-x-2 mt-2">
                  <Input
                    value={formName}
                    onChange={(e) => setFormName(e.target.value)}
                    className="bg-white/20 border-white/30 text-white placeholder-white/70 max-w-xs"
                    placeholder="Form Name"
                  />
                  <Badge variant="secondary" className="bg-white/20 text-white">
                    {formFields.length} fields
                  </Badge>
                </div>
              </div>
              <Plus className="h-8 w-8 opacity-70" />
            </div>
          </CardHeader>
          <CardContent className="p-6">
            <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
              <TabsList className="grid w-full grid-cols-4 mb-6">
                <TabsTrigger value="builder" className="flex items-center space-x-2">
                  <Plus className="h-4 w-4" />
                  <span>Builder</span>
                </TabsTrigger>
                <TabsTrigger value="preview" className="flex items-center space-x-2">
                  <Eye className="h-4 w-4" />
                  <span>Preview</span>
                </TabsTrigger>
                <TabsTrigger value="data" className="flex items-center space-x-2">
                  <Code2 className="h-4 w-4" />
                  <span>Data</span>
                </TabsTrigger>
                <TabsTrigger value="export" className="flex items-center space-x-2">
                  <Download className="h-4 w-4" />
                  <span>JSP Export</span>
                </TabsTrigger>
              </TabsList>

              <TabsContent value="builder" className="space-y-6">
                <FormFieldsPanel onAddField={addField} />
                <div className="space-y-4">
                  {formFields.map((field) => (
                    <Card key={field.id} className="border">
                      <CardHeader>
                        <div className="flex items-center justify-between">
                          <CardTitle className="text-lg">{field.label}</CardTitle>
                          <div className="flex items-center space-x-2">
                            <Badge variant={field.required ? "default" : "secondary"}>
                              {field.required ? "Required" : "Optional"}
                            </Badge>
                            <Button
                              variant="destructive"
                              size="sm"
                              onClick={() => removeField(field.id)}
                            >
                              Remove
                            </Button>
                          </div>
                        </div>
                      </CardHeader>
                      <CardContent className="grid gap-4">
                        <div className="grid gap-2">
                          <Label>Label</Label>
                          <Input
                            value={field.label}
                            onChange={(e) => updateField(field.id, { label: e.target.value })}
                          />
                        </div>
                        <div className="grid gap-2">
                          <Label>Name</Label>
                          <Input
                            value={field.name}
                            onChange={(e) => updateField(field.id, { name: e.target.value })}
                          />
                        </div>
                        {field.placeholder && (
                          <div className="grid gap-2">
                            <Label>Placeholder</Label>
                            <Input
                              value={field.placeholder}
                              onChange={(e) => updateField(field.id, { placeholder: e.target.value })}
                            />
                          </div>
                        )}
                        <div className="flex items-center space-x-2">
                          <Switch
                            checked={field.required}
                            onCheckedChange={(checked) => updateField(field.id, { required: checked })}
                          />
                          <Label>Required</Label>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              </TabsContent>

              <TabsContent value="preview">
                <FormPreview
                  fields={formFields}
                  formData={formData}
                  onDataChange={handleFormDataChange}
                  formName={formName}
                />
              </TabsContent>

              <TabsContent value="data">
                <FormDataPreview formData={formData} fields={formFields} />
              </TabsContent>

              <TabsContent value="export">
                <JSPExporter
                  fields={formFields}
                  formName={formName}
                  formData={formData}
                />
              </TabsContent>
            </Tabs>
          </CardContent>
        </Card>
      </div>

      <div className="space-y-6">
        <Card className="shadow-lg border-0 bg-white/80 backdrop-blur-sm">
          <CardHeader className="bg-gradient-to-r from-green-500 to-teal-500 text-white rounded-t-lg">
            <CardTitle className="flex items-center space-x-2">
              <Eye className="h-5 w-5" />
              <span>Live Preview</span>
            </CardTitle>
          </CardHeader>
          <CardContent className="p-4">
            <div className="text-sm text-gray-600 mb-2">
              Real-time form updates
            </div>
            <div className="text-2xl font-bold text-green-600">
              {Object.keys(formData).length} / {formFields.length} filled
            </div>
            <div className="w-full bg-gray-200 rounded-full h-2 mt-2">
              <div
                className="bg-gradient-to-r from-green-500 to-teal-500 h-2 rounded-full transition-all duration-300"
                style={{
                  width: formFields.length > 0 ? `${(Object.keys(formData).length / formFields.length) * 100}%` : '0%'
                }}
              ></div>
            </div>
          </CardContent>
        </Card>

        <Card className="shadow-lg border-0 bg-white/80 backdrop-blur-sm">
          <CardHeader className="bg-gradient-to-r from-orange-500 to-red-500 text-white rounded-t-lg">
            <CardTitle>Quick Stats</CardTitle>
          </CardHeader>
          <CardContent className="p-4 space-y-3">
            <div className="flex justify-between">
              <span className="text-gray-600">Total Fields:</span>
              <Badge variant="outline">{formFields.length}</Badge>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600">Required Fields:</span>
              <Badge variant="outline">{formFields.filter(f => f.required).length}</Badge>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600">Completion Rate:</span>
              <Badge variant="outline">
                {formFields.length > 0 ? Math.round((Object.keys(formData).length / formFields.length) * 100) : 0}%
              </Badge>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default FormBuilder;

