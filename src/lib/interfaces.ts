export interface TableData {
  name: string;
  pkey: string[];
}

export interface Response {
  headers: { name: string }[];
  values: string[][];
}

export interface InsertPayload {
  data: string[];
}

export interface UpdatePayload extends InsertPayload {
  pkey: string[];
  pkeyData: string[];
  headers: string[];
}

export interface DeletePayload {
  pkey: string[];
  pkeyData: string[];
}

export interface CostPayload {
  vehicleData: string[][];
  total: number;
}

export interface Alert {
  message: string;
  visible: boolean;
  type: "alert-success" | "alert-error";
}
