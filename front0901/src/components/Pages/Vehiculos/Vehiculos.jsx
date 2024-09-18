import React, { useState, useEffect } from 'react';
import { TextField, Container, Typography, Grid, Box, Button, MenuItem, Select, InputLabel } from '@mui/material';
import ApiRequest from '../../../helpers/axiosInstances';
import Page from '../../common/Page';
import ToastAutoHide from '../../common/ToastAutoHide';

const Vehiculos = () => {
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

    // Modificación para evitar desfase por zona horaria
    const formatDate = (date) => {
        if (!date) return '';
        const d = new Date(date);

        // Ajustar la fecha sumando horas para evitar el desfase por la zona horaria
        d.setHours(d.getHours() + 12);  // Sumar 12 horas para asegurar el día correcto

        const month = ('0' + (d.getMonth() + 1)).slice(-2);
        const day = ('0' + d.getDate()).slice(-2);
        return d.getFullYear() + '-' + month + '-' + day;
    };

    const [roles, setRoles] = useState([]);
    const [body, setBody] = useState(initialState);
    const [isEdit, setIsEdit] = useState(false);
    const [mensaje, setMensaje] = useState({ ident: null, message: null, type: null });

    const fetchRoles = async () => {
        try {
            const response = await ApiRequest().get('/proveedoresvvv');
            setRoles(response.data);
        } catch (error) {
            console.error('Error fetching roles data:', error);
        }
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
            setMensaje({
                ident: new Date().getTime(),
                message: data.message,
                type: 'success'
            });
            setBody(initialState);
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
            setMensaje({
                ident: new Date().getTime(),
                message: data.message,
                type: 'success'
            });
            setBody(initialState);
            setIsEdit(false);
        } catch ({ response }) {
            setMensaje({
                ident: new Date().getTime(),
                message: response.data.sqlMessage,
                type: 'error'
            });
        }
    };

    useEffect(() => {
        fetchRoles();
    }, []);

    return (
        <Page title="FF | Compras Vehiculos">
            <ToastAutoHide message={mensaje} />
            <Container maxWidth='lg'>
                <Box sx={{ pb: 5 }}>
                    <Typography variant="h5">Modulo {isEdit ? 'Editar Vehiculo' : 'Compras de Vehiculos'}</Typography>
                </Box>
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
                   
                    
                    <Grid item xs={12}>
                        <Button variant='contained' color='primary' onClick={isEdit ? onEdit : onSubmit}>
                            {isEdit ? 'Editar Producto' : 'Crear Producto'}
                        </Button>
                    </Grid>
                </Grid>
            </Container>
        </Page>
    );
};

export default Vehiculos;
