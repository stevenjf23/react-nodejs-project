import React, { useState, useEffect } from 'react';
import { TextField, Dialog, DialogTitle, DialogContent, DialogActions, Container, Typography, Grid, Box, Button, Stack, IconButton, Divider, MenuItem, Select, InputLabel } from '@mui/material';
import ApiRequest from '../../../helpers/axiosInstances';
import { AddOutlined, EditOutlined, DeleteOutline, PictureAsPdfOutlined } from '@mui/icons-material'; // Importa el ícono para el PDF
import Page from '../../common/Page';
import ToastAutoHide from '../../common/ToastAutoHide';
import CommonTable from '../../common/CommonTable';
import jsPDF from 'jspdf'; // Importa jsPDF
import 'jspdf-autotable'; // Importa el plugin autotable para tablas

const Predios = () => {
    const initialState = {
        id: "",	
        marca: "",	
        modelo: "",	
        numero_vin: "",	
        color: "",
        kilometraje: "",	
        tipo_combustible: "",	
        transmision: "",	
        numero_puertas: "",	
        numero_asientos: "",	
        numero_neumaticos: "",	
        id_proveedor_vehiculo: "",	
        precio_compra: "",	
        precio_vehiculo: "",	
        fecha_compra: ""




    };

    const formatDate = (date) => {
        if (!date) return '';
        const d = new Date(date);
        const month = ('0' + (d.getMonth() + 1)).slice(-2);
        const day = ('0' + d.getDate()).slice(-2);
        return d.getFullYear() + '-' + month + '-' + day;
    };

    const [roles, setRoles] = useState([]); // Lista de proveedores
    const [usuariosList, setUsuariosList] = useState([]);
    const [body, setBody] = useState(initialState);
    const [openDialog, setOpenDialog] = useState(false);
    const [isEdit, setIsEdit] = useState(false);
    const [mensaje, setMensaje] = useState({ ident: null, message: null, type: null });
    const [idDelete, setIdDelete] = useState(null);
    const [openDialogDelete, setOpenDialogDelete] = useState(false);

    // Función que obtiene la lista de productos
    const init = async () => {
        const { data } = await ApiRequest().get('/vehiculos');
        setUsuariosList(data);
    };

    // Función que obtiene la lista de proveedores
    const fetchProveedores = async () => {
        try {
            const { data } = await ApiRequest().get('/proveedoresv'); // Asegúrate que la ruta sea la correcta
            setRoles(data); // Actualiza el estado con la lista de proveedores
        } catch (error) {
            console.error('Error al obtener la lista de proveedores:', error);
        }
    };

    const columns = [
        { field: 'id', headerName: 'Codigo', width: 120 },
        { field: 'marca', headerName: 'Marca', width: 220 },
        { field: 'modelo', headerName: 'Modelo', width: 220 },
        { field: 'numero_vin', headerName: 'Numero de VIN', width: 220 },
        { field: 'color', headerName: 'Color', width: 220 },
        { field: 'kilometraje', headerName: 'Kilometraje', width: 220 },
        { field: 'tipo_combustible', headerName: 'Tipo de combustible', width: 220 },
        { field: 'transmision', headerName: 'Transmision', width: 220 },
        { field: 'numero_puertas', headerName: 'Numero de Puertas', width: 220 },
        { field: 'numero_asientos', headerName: 'Numero de Asientos', width: 220 },
        { field: 'numero_neumaticos', headerName: 'Numero de Neumaticos', width: 220 },


        { field: 'nombre_proveedor_vehiculo', headerName: 'Proveedor de Vehiculos', width: 220 },


        { field: 'precio_compra', headerName: 'Precio de Compra', width: 220 },
        { field: 'precio_vehiculo', headerName: 'Precio de Vehiculo', width: 220 },


        {
            field: 'fecha_compra',
            headerName: 'Fecha Compra',
            width: 220,
            valueFormatter: (params) => {
                const fecha = new Date(params.value);
                const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
                return fecha.toLocaleDateString('es-ES', options);
            }
        },
     



        
        {
            field: '',
            headerName: 'Acciones',
            width: 200,
            renderCell: (params) => (
                <Stack direction='row' divider={<Divider orientation="vertical" flexItem />} justifyContent="center" alignItems="center" spacing={2}>
                    <IconButton size='small' onClick={() => {
                        setIsEdit(true);
                        setBody(params.row);
                        handleDialog();
                    }}>
                        <EditOutlined />
                    </IconButton>
                    <IconButton size='small' onClick={() => {
                        handleDialogDelete();
                        setIdDelete(params.id);
                    }}>
                        <DeleteOutline />
                    </IconButton>
                </Stack>
            )
        }
    ];

    const onDelete = async () => {
        try {
            const { data } = await ApiRequest().post('/eliminar_vehic', { id: idDelete });
            setMensaje({
                ident: new Date().getTime(),
                message: data.message,
                type: 'success'
            });
            handleDialogDelete();
            init();
        } catch ({ response }) {
            setMensaje({
                ident: new Date().getTime(),
                message: response.data.sqlMessage,
                type: 'error'
            });
        }
    };

    const handleDialog = () => {
        setOpenDialog(prev => !prev);
    };

    const handleDialogDelete = () => {
        setOpenDialogDelete(prev => !prev);
    };

    const onChange = ({ target }) => {
        const { name, value } = target;
        setBody({
            ...body,
            [name]: value
        });
    };

    const onSubmit = async () => {
        try {
            const { data } = await ApiRequest().post('/guardar_vehic', body);
            handleDialog();
            setBody(initialState);
            setMensaje({
                ident: new Date().getTime(),
                message: data.message,
                type: 'success'
            });
            init();
            setIsEdit(false);
        } catch ({ response }) {
            setMensaje({
                ident: new Date().getTime(),
                message: response.data.sqlMessage,
                type: 'error'
            });
        }
    };

    const onEdit = async () => {
        try {
            const { data } = await ApiRequest().post('/editar_vehic', body);
            handleDialog();
            setBody(initialState);
            setMensaje({
                ident: new Date().getTime(),
                message: data.message,
                type: 'success'
            });
            init();
        } catch ({ response }) {
            setMensaje({
                ident: new Date().getTime(),
                message: response.data.sqlMessage,
                type: 'error'
            });
        }
    };

    // Función para generar el reporte PDF con todos los productos
    
    
    const generatePDF = () => {
        const doc = new jsPDF();
        doc.text("Reporte de Inventario Vehiculo", 20, 10);
        doc.autoTable({
            head: [['id', 'marca', 'modelo', 'numero_vin', 'color', 'kilometraje', 'tipo_combustible', 'transmision', 'numero_puertas', 'numero_asientos', 'numero_neumaticos', 'id_proveedor_vehiculo', 'precio_compra', 'precio_vehiculo', 'fecha_compra']],
            body: usuariosList.map(product => [
                product.id, 
                product.marca, 
                product.modelo, 
                product.numero_vin, 
                product.color,
                product.kilometraje,
                product.tipo_combustible,
                product.transmision,
                product.numero_puertas,
                product.numero_asientos,
                product.numero_neumaticos, 

                product.nombre_proveedor_vehiculo,
                
                product.precio_compra, 
                product.precio_vehiculo, 

                formatDate(product.fecha_compra), 
                
            ])
        });
        doc.save('reporte_inventario_vehiculos.pdf');
    };
    

  // Función para generar el reporte de productos de "QuimicosDeLaEra"
  const generatePDFQuimicosDeLaEra = () => {
    const doc = new jsPDF();
    const productosQuimicosDeLaEra = usuariosList.filter(product => product.nombre_proveedor === 'QuimicosDeLaEra');
    doc.text("Reporte de Productos - IAA", 20, 10);
    doc.autoTable({
        head: [['ID', 'Nombre', 'Descripción', 'Cantidad', 'Precio', 'Proveedor', 'Fecha Compra', 'Fecha Vencimiento', 'Numero Factura']],
        body: productosQuimicosDeLaEra.map(product => [
            product.id, 
            product.nombre, 
            product.descripcion, 
            product.cantidad, 
            product.precio, 
            product.nombre_proveedor, 
            formatDate(product.fecha_compra), 
            formatDate(product.fecha_vencimiento), 
            product.numero_factura
        ])
    });
    doc.save('reporte_quimicosdelaera.pdf');
};

    // Función para generar el reporte de productos de "Quimicos FERKICA"
    const generatePDFFerkica = () => {
        const doc = new jsPDF();
        const productosFerkica = usuariosList.filter(product => product.nombre_proveedor === 'Quimicos FERKICA');
        doc.text("Reporte de Productos - Quimicos FERKICA", 20, 10);
        doc.autoTable({
            head: [['ID', 'Nombre', 'Descripción', 'Cantidad', 'Precio', 'Proveedor', 'Fecha Compra', 'Fecha Vencimiento', 'Numero Factura']],
            body: productosFerkica.map(product => [
                product.id, 
                product.nombre, 
                product.descripcion, 
                product.cantidad, 
                product.precio, 
                product.nombre_proveedor, 
                formatDate(product.fecha_compra), 
                formatDate(product.fecha_vencimiento), 
                product.numero_factura
            ])
        });
        doc.save('reporte_quimicos_ferkica.pdf');
    };


    // Función para generar el reporte de productos del proveedor IAA
const generatePDFIAA = () => {
    const doc = new jsPDF();
    const vehiculosIAA = usuariosList.filter(product => product.nombre_proveedor_vehiculo === 'IAA');
    doc.text("Reporte de Vehículos - IAA", 20, 10);
    doc.autoTable({
        head: [['ID', 'Marca', 'Modelo', 'VIN', 'Color', 'Kilometraje', 'Combustible', 'Transmisión', 'Núm. Puertas', 'Núm. Asientos', 'Núm. Neumáticos', 'Proveedor', 'Precio Compra', 'Fecha Compra']],
        body: vehiculosIAA.map(vehicle => [
            vehicle.id, 
            vehicle.marca, 
            vehicle.modelo, 
            vehicle.numero_vin, 
            vehicle.color, 
            vehicle.kilometraje, 
            vehicle.tipo_combustible, 
            vehicle.transmision, 
            vehicle.numero_puertas, 
            vehicle.numero_asientos, 
            vehicle.numero_neumaticos, 
            vehicle.nombre_proveedor_vehiculo,
            vehicle.precio_compra, 
            formatDate(vehicle.fecha_compra)
        ])
    });
    doc.save('reporte_vehiculos_IAA.pdf');
};

// Función para generar el reporte de productos del proveedor Autowini
const generatePDFAutowini = () => {
    const doc = new jsPDF();
    const vehiculosAutowini = usuariosList.filter(product => product.nombre_proveedor_vehiculo === 'Autowini');
    doc.text("Reporte de Vehículos - Autowini", 20, 10);
    doc.autoTable({
        head: [['ID', 'Marca', 'Modelo', 'VIN', 'Color', 'Kilometraje', 'Combustible', 'Transmisión', 'Núm. Puertas', 'Núm. Asientos', 'Núm. Neumáticos', 'Proveedor', 'Precio Compra', 'Fecha Compra']],
        body: vehiculosAutowini.map(vehicle => [
            vehicle.id, 
            vehicle.marca, 
            vehicle.modelo, 
            vehicle.numero_vin, 
            vehicle.color, 
            vehicle.kilometraje, 
            vehicle.tipo_combustible, 
            vehicle.transmision, 
            vehicle.numero_puertas, 
            vehicle.numero_asientos, 
            vehicle.numero_neumaticos, 
            vehicle.nombre_proveedor_vehiculo,
            vehicle.precio_compra, 
            formatDate(vehicle.fecha_compra)
        ])
    });
    doc.save('reporte_vehiculos_Autowini.pdf');
};




























    
    // Al cargar el componente, obtenemos los productos y proveedores
    useEffect(() => {
        init();
        fetchProveedores(); // Carga los proveedores
    }, []);

    return (
        <>
            <Dialog maxWidth='xs' open={openDialogDelete} onClose={handleDialogDelete}>
                <DialogTitle>¿Eliminar Vehiculo?</DialogTitle>
                <DialogContent>
                    <Typography variant='h5'>Esta acción no se puede deshacer</Typography>
                </DialogContent>
                <DialogActions>
                    <Button variant='text' color='primary' onClick={handleDialogDelete}>Cancelar</Button>
                    <Button variant='contained' color='primary' onClick={onDelete}>Aceptar</Button>
                </DialogActions>
            </Dialog>
            
            <Dialog maxWidth='xs' open={openDialog} onClose={handleDialog}>
                <DialogTitle>{isEdit ? 'Formulario Editar Vehiculo' : 'Formulario Crear Vehiculo'}</DialogTitle>
                <DialogContent>
                    <Grid container spacing={2}>

                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='marca'
                            value={body.marca}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Marca'
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='modelo'
                            value={body.modelo}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Modelo'
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='numero_vin'
                            value={body.numero_vin}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Numero de VIN'
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='color'
                            value={body.color}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Color'
                        />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='kilometraje'
                            value={body.kilometraje}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Kilometraje'
                        />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='tipo_combustible'
                            value={body.tipo_combustible}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Tipo de combustible'
                        />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='transmision'
                            value={body.transmision}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Transmision'
                        />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='numero_puertas'
                            value={body.numero_puertas}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Numero de Puertas'
                        />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='numero_asientos'
                            value={body.numero_asientos}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Numero de Asientos'
                        />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='numero_neumaticos'
                            value={body.numero_neumaticos}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Numero de Neumaticos'
                        />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <InputLabel htmlFor="id_proveedor_vehiculo">Proveedor Vehiculo</InputLabel>
                        <Select
                            name="id_proveedor_vehiculo"
                            value={body.id_proveedor_vehiculo || ''}
                            onChange={onChange}
                            variant="outlined"
                            size="small"
                            fullWidth
                        >
                            {roles.map((id_prov) => (
                                <MenuItem key={id_prov.id} value={id_prov.id}>
                                    {id_prov.nombre}
                                </MenuItem>
                            ))}
                        </Select>
                    </Grid>




                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='precio_compra'
                            value={body.precio_compra}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Precio Compra'
                        />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField
                            margin='normal'
                            name='precio_vehiculo'
                            value={body.precio_vehiculo}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Precio Vehiculo'
                        />
                    </Grid>





                    <Grid item xs={12} sm={6}>
                        <TextField
                            type='date'
                            margin='normal'
                            name='fecha_compra'
                            value={formatDate(body.fecha_compra)}
                            onChange={onChange}
                            variant='outlined'
                            size='small'
                            fullWidth
                            label='Fecha Compra'
                            InputLabelProps={{
                                shrink: true,
                            }}
                        />
                    </Grid>
                        
                        
                        
                        
                        
                        







                    </Grid>
                </DialogContent>
                <DialogActions>
                    <Button variant='text' color='primary' onClick={handleDialog}>Cancelar</Button>
                    <Button variant='contained' color='primary' onClick={isEdit ? onEdit : onSubmit}>
                        {isEdit ? 'Editar Vehiculo' : 'Agregar Vehiculo'}
                    </Button>
                </DialogActions>
            </Dialog>
            <Page title="FF| Inventario Vehiculos">
                <ToastAutoHide message={mensaje} />
                <Container maxWidth='lg'>
                    <Box sx={{ pb: 5 }}>
                        <Typography variant="h5">Modulo de Inventario Vehiculos</Typography>
                    </Box>
                    <Grid container spacing={2}>

                        {
                        /*

                        <Grid item xs={12} sm={3}>
                           <Button onClick={() => {setIsEdit(false); handleDialog(); setBody(initialState);}} startIcon={<AddOutlined />} variant='contained' color='primary'> Agregar Producto</Button>
                        </Grid> 

                        */

}



                        <Grid item xs={12} sm={3}>
                            <Button onClick={generatePDF} startIcon={<PictureAsPdfOutlined />} variant='contained' color='primary'> Reporte Todos Los Vehiculos</Button>
                        </Grid>
                        {/*
                        <Grid item xs={12} sm={3}>
                            <Button onClick={generatePDFQuimicosDeLaEra} startIcon={<PictureAsPdfOutlined />} variant='contained' color='primary'> Reporte IAA</Button>
                        </Grid>
                        <Grid item xs={12} sm={3}>
                            <Button onClick={generatePDFFerkica} startIcon={<PictureAsPdfOutlined />} variant='contained' color='primary'> Reporte Autowini</Button>
                        </Grid>
*/
}

<Grid item xs={12} sm={3}>
    <Button onClick={generatePDFIAA} startIcon={<PictureAsPdfOutlined />} variant='contained' color='primary'>Reporte IAA</Button>
</Grid>
<Grid item xs={12} sm={3}>
    <Button onClick={generatePDFAutowini} startIcon={<PictureAsPdfOutlined />} variant='contained' color='primary'>Reporte Autowini</Button>
</Grid>




                        <Grid item xs={12} sm={12}>
                            <CommonTable data={usuariosList} columns={columns} />
                        </Grid>
                    </Grid>
                </Container>
            </Page>
        </>
    );
}

export default Predios;
